//
//  DataStorage.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import Foundation

final class DataStorage {
    
    // MARK: - Properties
    
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    // MARK: - Movies data storage methods
    
    static func saveMovieList(_ movies: [Movie]) {
        do {
            let encodedMovies = try self.encoder.encode(movies)
            UserDefaults.standard.set(encodedMovies, forKey: "MovieTable")
        } catch {
            debugPrint(String(describing: error))
        }
    }
    
    static func loadMovieList() -> [Movie]? {
        guard let data = UserDefaults.standard.data(forKey: "MovieTable") else { return nil }
        
        do {
            let movies = try self.decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            debugPrint(String(describing: error))
            return nil
        }
    }
    
    // MARK: - Authorization storage methods
    
    static func authSave(_ auth: Bool) {
        UserDefaults.standard.set(auth, forKey: "Logged")
    }
    
    static func authStatus() -> Bool? {
        return UserDefaults.standard.bool(forKey: "Logged")
    }
}
