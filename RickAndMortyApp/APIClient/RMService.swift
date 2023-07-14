//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import Foundation

/// Primary API service to get Rick & Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    
    /// Send Rick & Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
