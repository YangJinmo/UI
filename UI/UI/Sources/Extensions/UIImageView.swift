//
//  UIImageView.swift
//  UI
//
//  Created by Jmy on 2021/12/02.
//

import UIKit

extension UIImageView {
    func getAspectRatioConstraint(_ image: UIImage) -> Constraint {
        let constraint: Constraint = Constraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: image.aspect,
            constant: 0.0
        )
        constraint.priority = UILayoutPriority(rawValue: 999)
        return constraint
    }

    func setImage(urlString: String?) {
        let url: URL? = urlString.flatMap { $0.url }
        setImage(url: url)
    }

    func setImage(url: URL?) {
        guard let url: URL = url else { return }

        // 싱글 쓰레드로 동작하기 때문에 이미지를 다운로드 받기까지 잠깐의 멈춤이 발생할 수 있다.
        // DispatchQueue를 사용하면 멀티 쓰레드로 동작하여 멈춤이 생기지 않는다.
        DispatchQueue.global().async { [weak self] in
            do {
                let data: Data = try Data(contentsOf: url)

                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            } catch {
                error.localizedDescription.log()
            }
        }
    }

    // MARK: - Synchronously

    func setImageSynchronously(resource: String?, type: String? = "jpg") {
        guard
            let filePath: String = Bundle.main.path(forResource: resource, ofType: type),
            let image: UIImage = UIImage(contentsOfFile: filePath)
        else {
            return
        }
        self.image = image
    }

    // MARK: - Download

    func setImageDownload(url: URL?) {
        guard let url: URL = url else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                error.localizedDescription.log()
                return
            }

            guard
                let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode),
                let mimeType: String = httpResponse.mimeType, mimeType.hasPrefix("image"),
                let data: Data = data,
                let image: UIImage = UIImage(data: data)
            else {
                "Error: response, data, image".log()
                return
            }

            let filename: String = httpResponse.suggestedFilename ?? url.lastPathComponent
            filename.log()

            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }

    // MARK: - Retrieve Memory Cache

    func setImageRetrieveInMemoryCache(url: URL?) {
        guard let url: URL = url else { return }

        let cacheKey: NSString = NSString(string: url.absoluteString) // 캐시에 사용될 Key 값

        if let cachedImage: UIImage = ImageCacheManager.shared.object(forKey: cacheKey) { // 해당 Key에 캐시이미지가 저장되어 있으면 이미지를 사용
            image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    error.localizedDescription.log()
                    return
                }

                guard
                    let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode),
                    let mimeType: String = httpResponse.mimeType, mimeType.hasPrefix("image"),
                    let data: Data = data,
                    let image: UIImage = UIImage(data: data)
                else {
                    "Error: response, data, image".log()
                    return
                }

                let filename: String = httpResponse.suggestedFilename ?? url.lastPathComponent
                filename.log()

                DispatchQueue.main.async {
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                    self?.image = image
                }
            }
        }
    }

    // MARK: - Retrieve Disk Cache

    func setImageRetrieveInDiskCache(url: URL?) {
        guard let url: URL = url else { return }

        /**
         FileManager 인스턴스 생성. default는 FileManager 싱글톤 인스턴스를 만들어줍니다.
         FileManager는 URL 혹은 String 데이터 타입을 통해 파일에 접근할 수 있도록 합니다.
         Apple에서는 URL을 통한 파일 접근을 권장합니다.
         */
        let fileManager: FileManager = FileManager.default

        // 폴더 생성
        let urls: [URL] = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask // user's home directory --- place to install user's personal items (~)
        )

        guard let documentsDirectory: URL = urls.first else { return }

        let directoryName: String = "DiskCache"
        let directoryURL: URL = documentsDirectory.appendingPathComponent(directoryName)
        let directoryPath: String = directoryURL.path // .../Library/Caches/DiskCache

        if !fileManager.fileExists(atPath: directoryPath) {
            "\(directoryName)가 존재하지 않습니다.".log()
            do {
                try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: false, attributes: nil)
                "Create Directory: \(directoryName)".log()
            } catch {
                "Create Directory Error: \(error.localizedDescription)".log()
            }
        }

        // 파일 생성
        let fileName: String = "project_lunch.png"
        let fileURL: URL = directoryURL.appendingPathComponent(fileName)
        let filePath: String = fileURL.path

        if fileManager.fileExists(atPath: filePath) {
            "\(fileName)이 존재합니다.".log()
            setImage(url: fileURL)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    error.localizedDescription.log()
                    return
                }

                guard
                    let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode),
                    let mimeType: String = httpResponse.mimeType, mimeType.hasPrefix("image"),
                    let data: Data = data,
                    let image: UIImage = UIImage(data: data)
                else {
                    "Error: response, data, image".log()
                    return
                }

                let filename: String = httpResponse.suggestedFilename ?? url.lastPathComponent
                filename.log()

                DispatchQueue.main.async {
                    self?.image = image
                }

                guard let pngData: Data = image.pngData() else { return }
                fileManager.createFile(atPath: filePath, contents: pngData, attributes: nil)
            }
        }
    }
}

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}
