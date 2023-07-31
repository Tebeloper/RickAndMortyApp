//
//  RMSettingsViewController.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import SafariServices
import SwiftUI
import UIKit

/// Controller to show various app Options & Settings
final class RMSettingsViewController: UIViewController {
    
    /// A UIKit view controller that manages a SwiftUI view hierarchy.
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        
        /// A UIKit view controller that manages a SwiftUI view hierarchy.
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(
            viewModel: RMSettingsViewViewModel(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    return RMSettingsCellViewModel(type: $0) { [weak self] option in
                        self?.handleOption(option: option)
                    }
                })
            )
        )
        )
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleOption(option: RMSettingsOption) {
        guard Thread.isMainThread else {
            return
        }
        
        if let url = option.targetURL {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            
        }
    }
}
