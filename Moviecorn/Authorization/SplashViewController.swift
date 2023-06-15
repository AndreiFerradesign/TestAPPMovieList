//
//  SplashViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 31.05.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Layout elements
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        setupViews()
        setupLayouts()
        makeServiceCall()
    }
    
    // MARK: - Layout methods
    
    private func makeServiceCall() {
        indicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) { [self] in
            indicatorView.stopAnimating()
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                self.switchToMovieTableViewController()
            } else {
                self.switchToAuthViewController()
            }
        }
    }
    
    func switchToMovieTableViewController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        let movieTableViewController = MovieTableViewController()
        window.rootViewController = movieTableViewController
    }
    
    func switchToAuthViewController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        let authViewController = AuthViewController()
        window.rootViewController = authViewController
    }
    
    func setupViews() {
        view.addSubview(indicatorView)
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
