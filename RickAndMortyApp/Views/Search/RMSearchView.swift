//
//  RMSearchView.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 01/08/2023.
//

import UIKit

final class RMSearchView: UIView {
    
    private let viewModel: RMSearchViewViewModel
    
    // MARK: - Subviews
    
    private let noResultsView = RMNoSearchResultsView()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(noResultsView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            noResultsView.widthAnchor.constraint(equalToConstant: 250),
            noResultsView.heightAnchor.constraint(equalToConstant: 250),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
