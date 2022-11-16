//
//  UIImageView.swift
//  UI
//
//  Created by Jmy on 2021/12/02.
//

import UIKit.UIImageView

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}

extension UIImageView {
    // MARK: - Error

    private func toURL(urlString: String?) -> URL? {
        guard let urlString = urlString else {
            "Error: urlString is nil".log()
            return nil
        }
        guard let url = urlString.toURL else {
            return nil
        }
//        guard !urlString.isEmpty else {
//            "Error: urlString is empty".log()
//            return nil
//        }
//        guard let url = urlString.toURL else {
//            "Error: urlString is URL not Supported \(urlString)".log()
//            return nil
//        }
        return url
    }

    private func toData(data: Data?, response: URLResponse?, error: Error?) -> Data? {
        guard error == nil else {
            "\(error!)".log()
            return nil
        }
        guard let response = response as? HTTPURLResponse else {
            "Error: HTTP request failed".log()
            return nil
        }
        guard (200 ..< 300) ~= response.statusCode else {
            "Error: Status code: \(response.statusCode)".log()
            return nil
        }
        guard let mimeType = response.mimeType, mimeType.hasPrefix("image") else {
            "Error: MIMEType is not an image".log()
            return nil
        }
        guard let data = data else {
            "Error: Did not receive data".log()
            return nil
        }
        return data
    }

    // MARK: - Asynchronously

    func setImage(urlString: String?) {
        guard let url = toURL(urlString: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    self?.image = image
                }
            } catch {
                "Error: \(error)".log()
            }
        }
    }

    // MARK: - Synchronously

    func setImageSynchronously(resource: String?, type: String? = "jpg") {
        guard
            let filePath = Bundle.main.path(forResource: resource, ofType: type),
            let image = UIImage(contentsOfFile: filePath)
        else {
            return
        }
        self.image = image
    }

    // MARK: - Download

    func downloadImage(urlString: String?, placeholder: UIImage? = nil, completion: @escaping () -> Void) {
        if image == nil {
            image = placeholder
        }
        guard let url = toURL(urlString: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = self?.toData(data: data, response: response, error: error) else {
                return
            }
            let filename = response?.suggestedFilename ?? url.lastPathComponent
            filename.log()

            DispatchQueue.main.async(execute: { () in
                self?.image = UIImage(data: data)
                self?.setNeedsLayout()
                completion()
            })
//            DispatchQueue.main.async {
//                self?.image = UIImage(data: data)
//            }
        }
    }

    // MARK: - Retrieve Memory Cache

    func retrieveImageInMemoryCache(urlString: String?) {
        guard let url = toURL(urlString: urlString) else {
            return
        }
        let cacheKey = NSString(string: url.absoluteString)

        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard
                    let data = self?.toData(data: data, response: response, error: error),
                    let image = UIImage(data: data)
                else {
                    return
                }
                let filename = response?.suggestedFilename ?? url.lastPathComponent
                filename.log()

                DispatchQueue.main.async {
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    self?.image = image
                }
            }.resume()
        }
    }

    // MARK: - Retrieve Disk Cache

    func retrieveImageInDiskCache(urlString: String?) {
        guard let url = toURL(urlString: urlString) else {
            return
        }
        /**
         FileManager 인스턴스 생성. default는 FileManager 싱글톤 인스턴스를 만들어줍니다.
         FileManager는 URL 혹은 String 데이터 타입을 통해 파일에 접근할 수 있도록 합니다.
         Apple에서는 URL을 통한 파일 접근을 권장합니다.
         */
        let fileManager = FileManager.default // Returns the default singleton instance.

        // 폴더 생성
        let urls = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask // user's home directory --- place to install user's personal items (~)
        )

        guard let documentsDirectory = urls.first else {
            return
        }
        let directoryName = "DiskCache"
        let directoryURL = documentsDirectory.appendingPathComponent(directoryName)
        let directoryPath = directoryURL.path // .../Library/Caches/DiskCache

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
        let fileName = "project_lunch.png"
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let filePath = fileURL.path

        if fileManager.fileExists(atPath: filePath) {
            "\(fileName)이 존재합니다.".log()
            setImage(urlString: fileURL.absoluteString)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard
                    let data = self?.toData(data: data, response: response, error: error),
                    let image = UIImage(data: data)
                else {
                    return
                }
                let filename = response?.suggestedFilename ?? url.lastPathComponent
                filename.log()

                DispatchQueue.main.async {
                    self?.image = image
                }

                guard let pngData = image.pngData() else {
                    return
                }
                fileManager.createFile(atPath: filePath, contents: pngData, attributes: nil)
            }.resume()
        }
    }

    // MARK: - Constraint

    func getAspectRatioConstraint(_ image: UIImage) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: image.ratio,
            constant: 0.0
        )
        constraint.priority = UILayoutPriority(rawValue: 999)
        return constraint
    }
}
