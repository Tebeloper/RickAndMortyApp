//
//  RMTableLoadingFooterView.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 03/08/2023.
//

import UIKit

final class RMTableLoadingFooterView: UIView {

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(spinner)
        spinner.startAnimating()
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
