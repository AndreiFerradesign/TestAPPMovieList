//
//  Movie.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import Foundation

struct Movie: Codable {
    
    var poster: String?
    var movieName: String?
    var year: String?
    var plot: String?
    var runtime: String?
    
    private enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case movieName = "Title"
        case year = "Year"
        case plot = "Plot"
        case runtime = "Runtime"
    
    }
}
