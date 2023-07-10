//
//  RoutherMovieTable.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import UIKit

protocol RouterMovieTableProtocol: RouterProtocol {
    
    func initialView()
    func showDescription(data: Movie?)
    func popToRoot()
}

final class RouterMovieTable: RouterMovieTableProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var completionAuth: () -> Void
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol, completionAuth: @escaping () -> Void) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.completionAuth = completionAuth
    }
    
    // MARK: - Methods
    
    func initialView() {
        if let navigationController = navigationController {
            guard let movieTableViewController = assemblyBuilder?.createMovieTableModule(router: self) else { return }
            navigationController.viewControllers = [movieTableViewController]
        }
    }
    
    func showDescription(data: Movie?) {
        if let navigationController = navigationController {
            guard let movieDescriptionViewController = assemblyBuilder?.createDescriptionModule(data: data, router: self, completionAuth: completionAuth) else { return }
            navigationController.pushViewController(movieDescriptionViewController, animated: true)
            
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
