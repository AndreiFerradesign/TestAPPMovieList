//
//  MovieTableCell.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 31.05.2023.
//

import UIKit

final class MovieTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "MovieTableCell"
    
    private let networkService = NetworkService()
    
    private var movieImage: UIImage? {
        didSet {
            movieImageView.image = movieImage
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
        }
    }
    
    // MARK: - Layout elements
    
    private let movieTableCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Social Network"
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2010"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2h 00m"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rectView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.isHidden = false
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    // MARK: - Сell configuration
    
    func configCell(title: String?, runtime: String?, year: String?, imageLink: String?) {
        movieNameLabel.text = title
        timeConverter (minutes: runtime ?? "")
        yearLabel.text = year
        fetchImage(imageLink: imageLink)
    }
    
    // MARK: - Private methods
    
    private func fetchImage(imageLink: String?) {
        guard let url = URL(string: imageLink ?? String()) else { return }
        networkService.fetchImageData(from: url) { [weak self] image in
            guard let self = self else { return }
            self.movieImage = image
        }
    }
    
    private func timeConverter (minutes: String) {
        let time = minutes.split(separator: " ")
        let a: Int? = Int(time[0])
        let hour = Int(a ?? 0) / 60
        let minute = Int(a ?? 0) % 60
        self.runtimeLabel.text = String(format: "%1ih %02im", hour, minute)
    }
    
    private func initCell() {
        
        addSubview(movieTableCellView)
        self.addSubview(rectView)
        movieTableCellView.addSubview(movieImageView)
        movieTableCellView.addSubview(indicatorView)
        rectView.addSubview(movieNameLabel)
        rectView.addSubview(yearLabel)
        rectView.addSubview(runtimeLabel)
        
        NSLayoutConstraint.activate([
            
        movieTableCellView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        movieTableCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        movieTableCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        movieTableCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        
        rectView.topAnchor.constraint(equalTo: movieTableCellView.bottomAnchor, constant: -120),
        rectView.bottomAnchor.constraint(equalTo: movieTableCellView.bottomAnchor, constant: -12),
        rectView.leadingAnchor.constraint(equalTo: movieTableCellView.leadingAnchor, constant: 12),
        rectView.trailingAnchor.constraint(equalTo: movieTableCellView.trailingAnchor, constant: -12),
        
        movieImageView.topAnchor.constraint(equalTo: movieTableCellView.topAnchor, constant: 12),
        movieImageView.bottomAnchor.constraint(equalTo: movieTableCellView.bottomAnchor, constant: -12),
        movieImageView.leadingAnchor.constraint(equalTo: movieTableCellView.leadingAnchor, constant: 12),
        movieImageView.trailingAnchor.constraint(equalTo: movieTableCellView.trailingAnchor, constant: -12),
        movieImageView.heightAnchor.constraint(equalToConstant: 450),
        
        indicatorView.centerXAnchor.constraint(equalTo: movieTableCellView.centerXAnchor),
        indicatorView.centerYAnchor.constraint(equalTo: movieTableCellView.centerYAnchor),
        
        movieNameLabel.centerXAnchor.constraint(equalTo: rectView.centerXAnchor),
        movieNameLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 8),
        movieNameLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -45),
        
        yearLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 30),
        yearLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -10),
        
        runtimeLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -30),
        runtimeLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -10)
        
        ])
    }
}

