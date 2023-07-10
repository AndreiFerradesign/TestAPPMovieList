//
//  AssemblyBuilder.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    
    func createAuthModule(router: RouterAuthProtocol, completionAuth: @escaping () -> Void) -> UIViewController
    func createMovieTableModule(router: RouterMovieTableProtocol) -> UIViewController
    func createDescriptionModule(data: Movie?, router: RouterMovieTableProtocol, completionAuth: @escaping () -> Void) -> UIViewController
    
}

final class AssemblyBuiler: AssemblyBuilderProtocol {
    
    // MARK: - Methods
    
    func createAuthModule(router: RouterAuthProtocol, completionAuth: @escaping () -> Void) -> UIViewController {
        let view = AuthViewController()
        let presenter = AuthPresenter(
            view: view,
            router: router,
            completionAuth: completionAuth
        )
        view.presenter = presenter
        return view
    }
    
    func createMovieTableModule(router: RouterMovieTableProtocol) -> UIViewController {
        let view = MovieTableViewController()
        let networkService = NetworkService()
        let presenter = MovieTablePresenter(
            view: view,
            networkService: networkService,
            router: router
        )
        view.presenter = presenter
        return view
    }
    
    func createDescriptionModule(data: Movie?, router: RouterMovieTableProtocol, completionAuth: @escaping () -> Void) -> UIViewController {
        let view = MovieDescriptionViewController()
        let networkService = NetworkService()
        let presenter = MovieDescriptionPresenter(
            view: view ,
            networkService: networkService,
            data: data,
            router: router,
            completionAuth: completionAuth
        )
        view.presenter = presenter
        return view
    }
}

