//
//  RMSearchResultViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 02/08/2023.
//

import Foundation

enum RMSearchResultViewModel {
    case character([RMCharacterCollectionViewCellViewModel])
    case episode([RMCharacterEpisodeCollectionViewCellViewModel])
    case location([RMLocationTableViewCellViewModel])
}
