//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 27/07/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {return "None"}
        
        if let date = Self.dateFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemGray
            case .gender:
                return .systemPink
            case .type:
                return .systemGreen
            case .species:
                return .systemYellow
            case .origin:
                return .systemBlue
            case .location:
                return .systemPurple
            case .created:
                return .systemRed
            case .episodeCount:
                return .systemTeal
            }
        }
        
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "questionmark.app.fill")
            case .gender:
                return UIImage(systemName: "figure.dress.line.vertical.figure")
            case .type:
                return UIImage(systemName: "info.bubble.fill")
            case .species:
                return UIImage(systemName: "sprinkler.and.droplets.fill")
            case .origin:
                return UIImage(systemName: "globe.americas.fill")
            case .location:
                return UIImage(systemName: "mappin.and.ellipse")
            case .created:
                return UIImage(systemName: "calendar")
            case .episodeCount:
                return UIImage(systemName: "sum")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                    .gender,
                    .type,
                    .species,
                    .origin,
                    .location,
                    .created:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODES"
            }
        }
    }
    
    init(
        type: `Type`,
        value: String
    ) {
        self.value = value
        self.type = type
    }
}
