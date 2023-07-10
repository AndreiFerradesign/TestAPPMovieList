//
//  MovieTablePresenter.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import Foundation

protocol MovieTableViewProtocol: AnyObject {
    
    func success()
    func failure(error: BackendError)
}

protocol MovieTableViewPresenterProtocol: AnyObject {
    
    var data: [Movie] { get set }
    var filtredData: [Movie] { get }
    
    init(
        view: MovieTableViewProtocol,
        networkService: NetworkServiceProtocol,
        router: RouterMovieTableProtocol
    )
    
    func getData()
    func tapOnData(data: Movie?)
}

// MARK: - List of movie

fileprivate enum MovieList: String, CaseIterable {
    
    case one = "tt0120737"
    case two = "tt0265086"
    case three = "tt0093058"
    case four = "tt0111161"
    case five = "tt0068646"
    case six = "tt0108052"
    case seven = "tt0109830"
    case eight = "tt1375666"
    case nine = "tt0133093"
    case ten = "tt0120815"
    case eleven = "tt0110357"
    case twelve = "tt0163651"
    case thirteen = "tt1745960"
    case fourteen = "tt1285016"
}

final class MovieTablePresenter: MovieTableViewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: MovieTableViewProtocol?
    var networkService: NetworkServiceProtocol?
    var router: RouterMovieTableProtocol?
    var data: [Movie] = []
    
    var filtredData: [Movie] {
        return data.sorted {
            let firstValue = Int($0.year ?? "0")
            let secondValue = Int($1.year ?? "0")
            return (firstValue ?? Int()) < (secondValue ?? Int())
        }
    }
    
    // MARK: - Init
    
    required init(
        view: MovieTableViewProtocol,
        networkService: NetworkServiceProtocol,
        router: RouterMovieTableProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    // MARK: - Methods
    
    func getData() {
        
        let group = DispatchGroup()
        var data: [Movie] = []
        
        for film in MovieList.allCases {
            group.enter()
            networkService?.getMovieData(film: film.rawValue) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let model):
                    if let model = model {
                            data.append(model)
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                    data = DataStorage.loadMovieList() ?? []
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.data = data
            DataStorage.saveMovieList(data)
            self.view?.success()
        }
    }
    
    func tapOnData(data: Movie?) {
        router?.showDescription(data: data)
    }
}
