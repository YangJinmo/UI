//
//  QueryService.swift
//  UI
//
//  Created by Jmy on 2021/12/29.
//

import Foundation.NSURL

final class QueryService {
    // MARK: - Constants

    let defaultSession = URLSession(configuration: .default)

    // MARK: - Variables And Properties

    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var tracks: [Track] = []

    // MARK: - Type Alias

    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> Void

    // MARK: - Internal Methods

    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        dataTask?.cancel()

        guard var urlComponents = "https://itunes.apple.com/search".toURLComponents else {
            return
        }

        urlComponents.query = "media=music&entity=song&term=\(searchTerm)"

        guard let url = urlComponents.url else {
            errorMessage += "Error: " + urlComponents.description + "\n"
            return
        }

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }

            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            }

            guard
                let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode,
                let data = data
            else {
                return
            }

            self?.updateSearchResults(data)

            DispatchQueue.main.async {
                completion(self?.tracks, self?.errorMessage ?? "")
            }
        }

        dataTask?.resume()
    }

    // MARK: - Private Methods

    private func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?

        tracks.removeAll()

        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }

        guard let results = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }

        var index = 0

        for trackDictionary in results {
            guard
                let trackDictionary = trackDictionary as? JSONDictionary,
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = previewURLString.toURL,
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String
            else {
                errorMessage += "Problem parsing trackDictionary\n"
                return
            }

            tracks.append(
                Track(
                    name: name,
                    artist: artist,
                    previewURL: previewURL,
                    index: index
                )
            )
            index += 1
        }
    }
}
