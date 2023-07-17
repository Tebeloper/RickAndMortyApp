//
//  RMRequest.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    /// Path components for API, if any
    private let pathComponents: Set<String>
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed URL for the API request in String format
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
            
            if !queryParameters.isEmpty {
                string += "?"
                
                // name=value&name=value...
                let argumentString = queryParameters.compactMap{
                    
                    guard let value = $0.value else { return nil }
                    
                    return "\($0.name)=\(value)"
                }.joined(separator: "&")
                
                string += argumentString
            }
            
            return string
        
    }
    
    /// Computed & Constructed API URL
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired HTTP method
    public let httpMethod = "GET"
    
    // MARK: - public
    // ⌥ + ⌘ + /
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path Components
    ///   - queryParameters: Collection of Query parameters
    public init(
        endpoint: RMEndpoint,
        pathComponents: Set<String> = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
