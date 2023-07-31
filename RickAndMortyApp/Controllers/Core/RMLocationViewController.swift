//
//  RMLocationViewController.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {

    private let primaryView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Locations"
        
        addSearchButton()
        addConstraints()
        
        viewModel.delegate = self
        viewModel.fetchLocations()
        
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraints() {
        view.addSubview(primaryView)
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapSearch() {
        
    }
}

extension RMLocationViewController: RMLocationViewViewModelDelegate {
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}
