//
//  NetworkHandler.swift
//  UI
//
//  Created by Jmy on 2021/12/21.
//

import Foundation

struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}

final class NetworkHandler {
    // MARK: - Constants

    let defaultSession = URLSession(configuration: .default)

    // MARK: - Variables

    var dataTask: URLSessionDataTask?

    // MARK: - Methods

    func getData(resource: String, completion: @escaping (Any) -> Void) {
        dataTask?.cancel()

        guard let url = resource.toURL else {
            print("Error: cannot create URL")
            return
        }

        var urlRequest = url.toURLRequest
        urlRequest.httpMethod = "GET"

        dataTask = defaultSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }

            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            guard let jsonToArray: Any = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            DispatchQueue.main.async {
                completion(jsonToArray)
            }
        }
        dataTask?.resume()
    }

    func requestGet(resource: String, completion: @escaping (Any) -> Void) {
        dataTask?.cancel()

        guard let url = resource.toURL else {
            print("Error: cannot create URL")
            return
        }

        var urlRequest = url.toURLRequest
        urlRequest.httpMethod = "GET"

        dataTask = defaultSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }

            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            DispatchQueue.main.async {
                completion(output)
            }
        }
        dataTask?.resume()
    }

    func requestPost(resource: String, method: String, param: [String: Any], completion: @escaping (Any) -> Void) {
        dataTask?.cancel()

        let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])

        guard let url = resource.toURL else {
            print("Error: cannot create URL")
            return
        }

        var urlRequest = url.toURLRequest
        urlRequest.httpMethod = method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = sendData

        dataTask = defaultSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }

            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            DispatchQueue.main.async {
                completion(output)
            }
        }
        dataTask?.resume()
    }
}
