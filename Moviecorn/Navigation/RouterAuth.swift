//
//  RouterAuth.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import UIKit

protocol RouterAuthProtocol: RouterProtocol {
    
    func initialView()
    func popToRoot()
    
}

class RouterAuth: RouterAuthProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var completionAuth: () -> Void
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol?, completionAuth: @escaping () -> Void) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.completionAuth = completionAuth
    }
    
    // MARK: - Methods
    
    func initialView() {
        if let navigationController = navigationController {
            guard let authViewController = assemblyBuilder?.createAuthModule(router: self, completionAuth: completionAuth) else { return }
            navigationController.viewControllers = [authViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
