//
//  NetworkService.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import UIKit

protocol NetworkServiceProtocol {
    
    func getDataFromUrl<T: Codable>(url: URL, completion: @escaping BackendOperationHandler<T>)
    func getMovieData(film: String, competion: @escaping BackendOperationHandler<Movie>)
    
}

final class NetworkService: NetworkServiceProtocol {
    
    private var casheImage = NSCache<NSString, UIImage>()
    
    func getDataFromUrl<T: Codable>(url: URL, completion: @escaping BackendOperationHandler<T>) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(description: "Error")))
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(description: "Response error")))
                }
                return
            }
            DispatchQueue.main.async {
                
                switch StatusCode.returnResult(for: response.statusCode) {
                    
                case .information:
                    completion(.failure(.information(description: "Information error", statusCode: response.statusCode)))
                case .resursive:
                    completion(.failure(.redirection(description: "Error", statusCode: response.statusCode)))
                case .authError:
                    completion(.failure(.authError(description: "Authorization error", statusCode: response.statusCode)))
                case .clientError:
                    completion(.failure(.clientError(description: "Clients error", statusCode: response.statusCode)))
                case .serverError:
                    completion(.failure(.serverError(description: "Server error", statusCode: response.statusCode)))
                case .success:
                    guard let data = data else {
                        completion(.failure(.unresolved(description: "Data nil", statusCode: response.statusCode)))
                        return
                    }
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    }
                    catch {
                        completion(.failure(.decodeError(description: "Catch error")))
                    }
                }
            }
        }.resume()
    }
    
    func fetchImageData(from url: URL, completion: @escaping (UIImage) -> Void) {
        
        if let cashedImage = casheImage.object(forKey: url.absoluteString as NSString) {
            completion(cashedImage)
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let mimeType = response.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            self.casheImage.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}


extension NetworkService {
    
    func getMovieData(film: String, competion: @escaping BackendOperationHandler<Movie>) {
        getDataFromUrl(url: MovieSourceURL.getMovieUrl(film: film), completion: competion)
    }
}

