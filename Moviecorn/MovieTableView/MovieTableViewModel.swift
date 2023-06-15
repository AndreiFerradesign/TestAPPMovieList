//
//  MovieTableViewModel.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 15.06.2023.
//

import Foundation

class MovieTableViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: MovieTableViewModel?
    var movies: Observable<[MovieTableCellViewModel]> = Observable(nil)
    
//    func numberOfRows(in section: Int) -> Int {
// //       return dataSource?.results.count ?? 0
//    }
}
