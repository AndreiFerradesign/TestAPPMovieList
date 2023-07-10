//
//  MovieDescriptionViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 30.05.2023.
//

import UIKit


final class MovieDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: MovieDescriptionPresenterProtocol?
    private var data: Movie?
    private let networkService = NetworkService()
    
    // MARK: - Layout elements
    
    private var movieSingleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "0")
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
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "About movie"
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
        view.backgroundColor = .white
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoutButton: UIButton = {
        let buttonImage = UIImage(systemName: "ipad.and.arrow.forward")
        let button = UIButton.systemButton(with: buttonImage!,
                                           target: nil,
                                           action: #selector(didTapLogoutButton))
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var backButton: UIButton = {
        let buttonImage = UIImage(systemName: "chevron.backward")
        let button = UIButton.systemButton(with: buttonImage!,
                                           target: nil,
                                           action: #selector(didTapBackButton))
        button.tintColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMovieDescriptionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        presenter?.getData()
        updateDescription()
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackButton() {
        presenter?.tapBack()
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
                presenter?.tapLogOut()
            }))
        alert.addAction(UIAlertAction(
            title: "Нет",
            style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - Private methods
    
    private func updateDescription() {
        
        self.movieNameLabel.text = data?.movieName
        self.descriptionLabel.text = data?.plot
        fetchImage(imageLink: data?.poster)
    }
    
    private func fetchImage(imageLink: String?) {
        guard let url = URL(string: imageLink ?? String()) else { return }
        networkService.fetchImageData(from: url) { [weak self] image in
            guard let self = self else { return }
            self.movieSingleImageView.image = image
        }
    }
    
    private func initMovieDescriptionView() {
        
        view.backgroundColor = .background
        
        view.addSubview(movieSingleImageView)
        view.addSubview(rectView)
        view.addSubview(movieNameLabel)
        view.addSubview(aboutMovieLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(logoutButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            movieSingleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            movieSingleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieSingleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            movieSingleImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            rectView.topAnchor.constraint(equalTo: movieSingleImageView.bottomAnchor, constant: 0),
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

// MARK: - MovieDescriptionViewProtocol

extension MovieDescriptionViewController: MovieDescriptionViewProtocol {
    
    func setData(data: Movie?) {
        self.data = data
    }
}

