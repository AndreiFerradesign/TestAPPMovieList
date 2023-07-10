//
//  MovieSourceURL.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import Foundation

struct MovieSourceURL {
    
    static func getMovieUrl(film: String) -> URL {
        let url = URL(string: "https://www.omdbapi.com/?apikey=\(accountKeyOMDB)&i=\(film)")!
        return url
    }
}
