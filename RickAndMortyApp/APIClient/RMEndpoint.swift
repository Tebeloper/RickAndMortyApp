//
//  RMEndpoint.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import Foundation

/// Represents a unique API endpoint
@frozen enum RMEndpoint: String {
    
    /// Endpoint to get character info
    case character // "character"
    /// Endpoint to get location info
    case location // "location"
    /// Endpoint to get episode info
    case episode // "episode"
}
