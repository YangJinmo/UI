//
//  IssuesService.swift
//  UI
//
//  Created by Jmy on 2022/01/13.
//

import Foundation.NSURL

final class IssuesService {
    func getIssues<T: Decodable>(api: API, completion: @escaping (Result<[T], APIError>) -> Void) {
        guard let url = api.path.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                let result = try JSONDecoder().decode([T].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
}
