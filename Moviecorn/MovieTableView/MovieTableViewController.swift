//
//  MovieTableViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 30.05.2023.
//

import UIKit

final class MovieTableViewController : UIViewController {
    
    // MARK: - Layout elements
    
    let networkDataFetcher = NetworkDataFetcher()
    
    let tableView = UITableView()
    var viewModel: MovieTableViewModel = MovieTableViewModel()
    
    private var posterImages: [String] = Array(0..<20).map{ "\($0)" }
    var moviesDataSource: [MovieTableCellViewModel] = []
 //   private var posterImages: [String] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        }
        // MARK: - Layout methods
        

        
        func setupTableView() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
            tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.reuseIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.backgroundColor = .background
        }
    }

// MARK: - UITableViewDataSource

extension MovieTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.reuseIdentifier, for: indexPath)
        
        guard let movieTableCell = cell as? MovieTableCell else {
            return UITableViewCell()
        }
        configCell(for: movieTableCell, with: indexPath)
        return movieTableCell
    }
}

//MARK: - Заполнение ячеек

extension MovieTableViewController {

    func configCell(for cell: MovieTableCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: posterImages[indexPath.row]) else {
            return
        }
        cell.movieImageView.image = image
        cell.movieNameLabel.text = "The Social Media"
        cell.yearLabel.text = "2010"
        cell.runtimeLabel.text = "2h 00m"

    }
}

// MARK: - переход по нажатию ячейки UITableViewDelegate

extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let rootVC = MovieDescriptionViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
        
    }
}
