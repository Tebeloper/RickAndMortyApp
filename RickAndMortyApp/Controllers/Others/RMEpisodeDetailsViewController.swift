//
//  RMEpisodeDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 28/07/2023.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailsViewController: UIViewController {

    private let viewModel: RMEpisodeDetailsViewViewModel
    
    // MARK: - Init
    
    init(url: URL?) {
        self.viewModel = .init(endpointURL: url)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Episode"
        view.backgroundColor = .systemBackground
    }
}
