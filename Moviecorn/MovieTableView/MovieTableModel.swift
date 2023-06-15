//
//  MovieTableService.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 01.06.2023.
//

import Foundation

struct Movie: Codable {
    var poster: String?
    var title: String?
    var year: String?
    var runtime: String?
    
    private enum CodingKeys: String, CodingKey {
            case poster = "Poster"
            case title = "Title"
            case year = "Year"
            case runtime = "Runtime"
            }
}
