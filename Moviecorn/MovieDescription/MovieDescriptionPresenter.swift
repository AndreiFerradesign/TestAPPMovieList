//
//  MovieDescriptionPresenter.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 03.07.2023.
//

import Foundation


protocol MovieDescriptionViewProtocol: AnyObject {
    
    func setData(data: Movie?)
}

protocol MovieDescriptionPresenterProtocol: AnyObject {
    
    init(
        view: MovieDescriptionViewProtocol,
        networkService: NetworkServiceProtocol,
        data: Movie?,
        router: RouterMovieTableProtocol,
        completionAuth: @escaping () -> Void
    )
    
    func getData()
    func tapBack()
    func tapLogOut()
}

final class MovieDescriptionPresenter: MovieDescriptionPresenterProtocol {
    
    // MARK: - Properties
    
    var data: Movie?
    weak var view: MovieDescriptionViewProtocol?
    let networkService: NetworkServiceProtocol?
    let router: RouterMovieTableProtocol?
    let completionAuth: () -> Void
    
    // MARK: - Init
    
    required init(
        view: MovieDescriptionViewProtocol,
        networkService: NetworkServiceProtocol,
        data: Movie?,
        router: RouterMovieTableProtocol,
        completionAuth: @escaping () -> Void
    ) {
        self.view = view
        self.networkService = networkService
        self.data = data
        self.router = router
        self.completionAuth = completionAuth
    }
    
    // MARK: - Methods
    
    func getData() {
        view?.setData(data: data)
    }
    
    func tapBack() {
        router?.popToRoot()
    }
    
    func tapLogOut() {
        completionAuth()
    }
    
}
