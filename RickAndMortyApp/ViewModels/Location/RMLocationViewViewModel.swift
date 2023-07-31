//
//  RMLocationViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 01/08/2023.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    private var cellViewModels: [String] = []
    init() {}
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequest, expecting: [RMLocation].self) { results in
            switch results {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print((String(describing: error)))
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
