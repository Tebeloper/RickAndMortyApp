//
//  RMSearchInputViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 01/08/2023.
//

import Foundation

final class RMSearchInputViewViewModel {
    
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOptions: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    // MARK: - Init
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    // MARK: - Public
    
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case.episode:
            return false
        }
    }
    
    public var options: [DynamicOptions] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case.episode:
            return []
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Search Character Name..."
        case .location:
            return "Search Location Name..."
        case.episode:
            return "Search Episode Title..."
        }
    }

}
