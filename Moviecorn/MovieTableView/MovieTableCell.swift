//
//  MovieTableCell.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 31.05.2023.
//

import UIKit

final class MovieTableCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieTableCell"
    
//    func configure(image: UIImage?) {
//        movieImageView.image = image
//    }
    
    // MARK: - Layout elements
    
    let movieTableCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Social Network"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2010"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2h 00m"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rectView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieTableCellView)
        movieTableCellView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        movieTableCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        movieTableCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieTableCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        self.addSubview(rectView)
        rectView.topAnchor.constraint(equalTo: movieTableCellView.bottomAnchor, constant: -120).isActive = true
        rectView.bottomAnchor.constraint(equalTo: movieTableCellView.bottomAnchor, constant: -12).isActive = true
        rectView.leadingAnchor.constraint(equalTo: movieTableCellView.leadingAnchor, constant: 12).isActive = true
        rectView.trailingAnchor.constraint(equalTo: movieTableCellView.trailingAnchor, constant: -12).isActive = true
        
        movieTableCellView.addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: movieTableCellView.topAnchor, constant: 12).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: movieTableCellView.bottomAnchor, constant: -12).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: movieTableCellView.leadingAnchor, constant: 12).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: movieTableCellView.trailingAnchor, constant: -12).isActive = true
        
        rectView.addSubview(movieNameLabel)
        movieNameLabel.centerXAnchor.constraint(equalTo: rectView.centerXAnchor).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 8).isActive = true
        movieNameLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -45).isActive = true
        
        rectView.addSubview(yearLabel)
        yearLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 30).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -10).isActive = true
        
        rectView.addSubview(runtimeLabel)
        runtimeLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -30).isActive = true
        runtimeLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupCell(viewModel: MovieTableCellViewModel) {
//        self.movieNameLabel.text = viewModel.title
//        self.yearLabel.text = viewModel.year
//        self.runtimeLabel.text = viewModel.runtime
//        //self.movieImageView.sd_setImage(with: viewModel.image)
//    }
    
}
