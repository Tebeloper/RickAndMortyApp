//
//  RMAPICacheManager.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 28/07/2023.
//

import Foundation

/// Manages in memory session scoped API caches
final class RMAPICacheManager {
    
    private var cachedDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    
    init() {
        setUpCache()
    }
    
    // MARK: - Public
    
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cachedDictionary[endpoint], let url = url else {
            return nil
        }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cachedDictionary[endpoint], let url = url else {
            return
        }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private
    
    private func setUpCache() {
        RMEndpoint.allCases.forEach { endpoint in
            cachedDictionary[endpoint] = NSCache<NSString, NSData>()
        }
        
    }
}
