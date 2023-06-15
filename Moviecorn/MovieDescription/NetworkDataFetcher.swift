//
//  NetworkDataFetcher.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.06.2023.
//

import UIKit


class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetch(urlString: String, response: @escaping (MovieDescriptionModel?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let movieData = try JSONDecoder().decode(MovieDescriptionModel.self, from: data)
                    response(movieData)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let posterImage = try? JSONDecoder().decode(MovieDescriptionModel.self, from: data) {
                self.loadImageContent(url: posterImage.posterURL, completion: completion)
                print(posterImage.plot)
            }
        }
        task.resume()
    }

    private func loadImageContent(url: String, completion: @escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            if let data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

