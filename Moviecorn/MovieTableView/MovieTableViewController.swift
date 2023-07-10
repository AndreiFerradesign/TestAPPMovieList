//
//  MovieTableViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 30.05.2023.
//

import UIKit

final class MovieTableViewController : UIViewController {
    
    // MARK: - Properties
    
    var presenter: MovieTableViewPresenterProtocol?
    
    // MARK: - Layout elements
    
    private let tableView = UITableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        presenter?.getData()
    }
    
    // MARK: - Layout methods
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .background
        tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - MovieTableViewProtocol

extension MovieTableViewController: MovieTableViewProtocol {
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: BackendError) {
        print("Error")
    }
}

// MARK: - UITableViewDataSource

extension MovieTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filtredData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.reuseIdentifier, for: indexPath)  as! MovieTableCell
        
        let data = presenter?.filtredData[indexPath.row]
        
        cell.configCell(title: data?.movieName,
                        runtime: data?.runtime,
                        year: data?.year,
                        imageLink: data?.poster
        )
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = presenter?.filtredData[indexPath.row]
        presenter?.tapOnData(data: data)
        
    }
}



