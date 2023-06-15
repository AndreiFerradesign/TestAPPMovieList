//
//  MovieTableCellViewModel.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 15.06.2023.
//
import Foundation

class MovieTableCellViewModel {
    
    var poster: URL?
    var title: String?
    var year: String?
    var runtime: String?
    
    init(movie: Movie) {
        self.poster = makeImageURL(movie.poster ?? "")
        self.title = movie.title
        self.year = movie.year
        self.runtime = movie.runtime
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(defaultBaseURL)\(imageCode)")
    }
}
