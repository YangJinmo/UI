//
//  String.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import UIKit

extension String {
    var encode: String? {
        var allowedQueryParamAndKey: CharacterSet = .urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    var url: URL? {
        return URL(string: self)
    }

    var image: UIImage? {
        guard
            let url: URL = url,
            let data: Data = try? Data(contentsOf: url),
            let image: UIImage = UIImage(data: data)
        else {
            return nil
        }
        return image
    }

    func open() {
        guard let url: URL = url else { return }
        url.open()
    }

    func log(function: String = #function, _ value: Any = "", _ comment: String = "") {
        print("func \(function) \(comment)\(self)")
    }
}
