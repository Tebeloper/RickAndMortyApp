//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 01/08/2023.
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable, Equatable {
    
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public var name: String {
        return "Planet: "+location.name
    }
    
    public var type: String {
        return "Type: "+location.type
    }
    
    public var dimension: String {
        return "Dimension: "+location.dimension
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(location.id)
        hasher.combine(dimension)
        hasher.combine(type)
    }
}
