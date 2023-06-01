//
//  MovieDescriptionViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 30.05.2023.
//

import UIKit

final class MovieDescriptionViewController: UIViewController {
    
//    var image: UIImage! {
//            didSet {
//                guard isViewLoaded else { return }
//                movieSingleImageView.image = image
//            }
//        }
    
    // MARK: - Layout elements
    
    private let movieSingleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "0")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Social Media"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "О фильме"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "A pragmatic U.S. Marine observes the dehumanizing effects the Vietnam War has on his fellow recruits from their brutal boot camp training to the bloody street fighting in Hue."
        label.textAlignment = .center
        label.numberOfLines = 15
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rectView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoutButton: UIButton = {
        let buttonImage = UIImage(systemName: "ipad.and.arrow.forward")
        let button = UIButton.systemButton(with: buttonImage!,
                                           target: nil,
                                           action: #selector(didTapLogoutButton))
        button.tintColor = .red
        return button
    }()
    
    private var backButton: UIButton = {
        let buttonImage = UIImage(systemName: "chevron.backward")
        let button = UIButton.systemButton(with: buttonImage!,
                                           target: nil,
                                           action: #selector(didTapBackButton))
        button.tintColor = .white
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        movieSingleImageView.image = image
        
        initMovieDescriptionViewController()
    }
    
    // MARK: - Layout methods
    
    @objc private func didTapBackButton() {
        
        dismiss(animated: true, completion: nil)
//        guard let window = UIApplication.shared.windows.first else {
//            assertionFailure("Invalid Configuration")
//            return
//        }
//        let movieTableViewController = MovieTableViewController()
//        window.rootViewController = movieTableViewController
    }
    
    @objc private func didTapLogoutButton() {
        
        let alert = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены что хотите выйти?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Да",
            style: .default,
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.logOut()
            }))
        alert.addAction(UIAlertAction(
            title: "Нет",
            style: .default))
        self.present(alert, animated: true)
    }
    
    private func logOut() {
        
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        let authViewController = AuthViewController()
        window.rootViewController = authViewController
    }
    
    private func initMovieDescriptionViewController() {
        
        view.backgroundColor = .background
        
        movieSingleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieSingleImageView)
        
        rectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectView)
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieNameLabel)
        
        aboutMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutMovieLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            movieSingleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            movieSingleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieSingleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            movieSingleImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            rectView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -450),
            rectView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            rectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            rectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            movieNameLabel.centerXAnchor.constraint(equalTo: rectView.centerXAnchor),
            movieNameLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 30),
            movieNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            movieNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            aboutMovieLabel.centerXAnchor.constraint(equalTo: rectView.centerXAnchor),
            aboutMovieLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: rectView.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 20),
            
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoutButton.widthAnchor.constraint(equalToConstant: 30),
            logoutButton.heightAnchor.constraint(equalToConstant: 30),
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
