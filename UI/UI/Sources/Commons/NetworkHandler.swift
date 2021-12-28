//
//  NetworkHandler.swift
//  UI
//
//  Created by Jmy on 2021/12/21.
//

import Foundation

class NetworkHandler {
    static func getData(resource: String) {
        guard let url: URL = resource.url else {
            "Resource URL is nil".log()
            return
        }

        let defaultSession: URLSession = URLSession(configuration: .default)
        let request: URLRequest = URLRequest(url: url)
        let dataTask: URLSessionDataTask = defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error: Error = error {
                error.localizedDescription.log()
                return
            }

            guard
                let response: HTTPURLResponse = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode),
                let data: Data = data
            else {
                return
            }

            guard let jsonToArray: Any = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("json to Any Error")
                return
            }
            print(jsonToArray)
        }
        dataTask.resume()
    }
}
