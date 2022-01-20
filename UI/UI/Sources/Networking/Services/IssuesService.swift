//
//  IssuesService.swift
//  UI
//
//  Created by Jmy on 2022/01/13.
//

import Foundation.NSURL

final class IssuesService {
    // MARK: - Constants

    let defaultSession = URLSession(configuration: .default)

    // MARK: - Variables And Properties

    var dataTask: URLSessionDataTask?

    // MARK: - Internal Methods

    func getIssues<T: Decodable>(api: API, completion: @escaping (Result<[T], APIError>) -> Void) {
        dataTask?.cancel()

        guard let url = api.path.url else {
            completion(.failure(.urlNotSupport))
            return
        }

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }

            guard error == nil else {
                completion(.failure(.error(error!)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            guard (200 ..< 300) ~= response.statusCode else {
                completion(.failure(.responseCode(response.statusCode)))
                return
            }
            do {
                // let result = try JSONDecoder().decode([T].self, from: data)
                let result = try data.decoded() as [T]

                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.parseError))
            }
        }

        dataTask?.resume()
    }
}
