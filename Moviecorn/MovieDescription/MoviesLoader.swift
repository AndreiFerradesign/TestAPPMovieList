//
//  MoviesLoader.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 01.06.2023.
//

import Foundation

//protocol MoviesLoading {
//    func loadMovies(handler: @escaping (Result<Description, Error>) -> Void )
//}
//
//struct MoviesLoader: MoviesLoading {
//    // MARK: - NetworkClient
//    private let networkClient = NetworkClient()
//    
//    // MARK: - URL
//    private var mostPopularMoviesUrl: URL {
//           // Если мы не смогли преобразовать строку в URL, то приложение упадёт с ошибкой
//           guard let url = URL(string: "http://www.omdbapi.com/?apikey=fd2706fb&i=tt0093058") else {
//               preconditionFailure("Unable to construct mostPopularMoviesUrl")
//           }
//           return url
//       }
//    
//    func loadMovies(handler: @escaping (Result<Description, Error>) -> Void ) {
//        
//        networkClient.fetch(url: mostPopularMoviesUrl) { result in
//                 switch result {
//                 case .success(let data):
//                     do {
//                         let movies = try JSONDecoder().decode(Description.self, from: data)
//                         handler(.success(movies))
//                     } catch let jsonError {
//                         handler(.failure(jsonError))
//                     }
//                 case .failure(let responseError):
//                     handler(.failure(responseError))
//            }
//        }
//    }
//}
