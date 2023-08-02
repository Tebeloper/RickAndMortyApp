//
//  RMNoSearchResultsView.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 01/08/2023.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true

        addSubviews(imageView, label)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
//            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    private func configure() {
        imageView.image = viewModel.image
        label.text = viewModel.title
    }
    
}
