//
//  Launcher.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import UIKit

final class Launcher {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol
    var auth: Bool = false
    
    // MARK: - Init
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol, auth: Bool) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.auth = auth
    }
    
    // MARK: - Methods
    
    func launch() {
        if auth {
            let router = RouterMovieTable(navigationController: self.navigationController!, assemblyBuilder: self.assemblyBuilder) {
                self.auth = false
                DataStorage.authSave(self.auth)
                let router = RouterAuth(
                    navigationController: self.navigationController!,
                    assemblyBuilder: self.assemblyBuilder,
                    completionAuth: { [weak self] in
                        guard let self = self else { return }
                        self.auth = true
                        DataStorage.authSave(self.auth)
                        self.launch()
                    }
                )
                router.initialView()
            }
            router.initialView()
        } else {
            let router = RouterAuth(navigationController: self.navigationController!, assemblyBuilder: self.assemblyBuilder) {
                self.auth = true
                DataStorage.authSave(self.auth)
                let router = RouterMovieTable(
                    navigationController: self.navigationController!,
                    assemblyBuilder: self.assemblyBuilder,
                    completionAuth: { [weak self] in
                        guard let self = self else { return }
                        self.auth = false
                        DataStorage.authSave(self.auth)
                        self.launch()
                    }
                )
                router.initialView()
            }
            router.initialView()
        }
    }
}
