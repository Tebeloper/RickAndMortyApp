//
//  RMSettingsOption.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 31/07/2023.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contact
    case terms
    case privacy
    case apiReference
    case viewCode
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contact:
            return URL(string: "https://www.linkedin.com/in/dimitris-gkarlemos")
        case .terms:
            return nil
        case .privacy:
            return nil
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com")
        case .viewCode:
            return URL(string: "https://github.com/Tebeloper/RickAndMortyApp")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App "
        case .contact:
            return "Contact Us"
        case .terms:
            return "Terms of Service "
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "Source (GitHub)"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemYellow
        case .contact:
            return .systemBlue
        case .terms:
            return .systemOrange
        case .privacy:
            return .systemPurple
        case .apiReference:
            return .systemGreen
        case .viewCode:
            return .systemBlue
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contact:
            return UIImage(systemName: "envelope.fill")
        case .terms:
            return UIImage(systemName: "doc.fill")
        case .privacy:
            return UIImage(systemName: "lock.fill")
        case .apiReference:
            return UIImage(systemName: "network")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
