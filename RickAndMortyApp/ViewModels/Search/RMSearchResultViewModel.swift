//
//  RMSearchResultViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 02/08/2023.
//

import Foundation

final class RMSearchResultViewModel {
    public private (set) var results: RMSearchResultViewType
    private var next: String?
    
    init(results: RMSearchResultViewType, next: String?) {
        self.results = results
        self.next = next
    }
    
    public private (set) var isLoadingMoreResults = false
    
    public var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    /// Paginate if additional Locations needed
    public func fetchAdditionalLocations(completion: @escaping ([RMLocationTableViewCellViewModel]) -> Void) {
        
        guard !isLoadingMoreResults else {
            return
        }
        
        guard let nextURLString = next,
              let url = URL(string: nextURLString) else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreResults = false
            return
        }
        
        RMService.shared.execute(
            request,
            expecting: RMGetAllLocationsResponse.self) { [weak self] result in
                
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // Capture new URL
                    
                    let additionalLocations = moreResults.compactMap({
                        return RMLocationTableViewCellViewModel(location: $0)
                    })
                    
                    var newResults: [RMLocationTableViewCellViewModel] = []
                    
                    switch strongSelf.results {
                    case .location(let existingResults):
                        newResults = existingResults + additionalLocations
                        strongSelf.results = .location(newResults)
                    case .character, .episode:
                        break
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        //Notify via callback
                        completion(newResults)
                    }
                    
                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreResults = false
                }
            }
    }
}

enum RMSearchResultViewType {
    case character([RMCharacterCollectionViewCellViewModel])
    case episode([RMCharacterEpisodeCollectionViewCellViewModel])
    case location([RMLocationTableViewCellViewModel])
}
