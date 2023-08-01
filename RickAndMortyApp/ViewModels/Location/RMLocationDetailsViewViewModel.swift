//
//  RMLocationDetailsViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 01/08/2023.
//

import Foundation

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailsViewViewModel {
    private let endpointURL: URL?
    
    private var dataTuple: (location: RMLocation, character: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SectionType {
        case info(viewModel: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    // This property is public but ONLY for reading data
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Init
    
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
    }
    
    // MARK: - Public
    
    /// Fetch backing location model
    public func fetchLocationData() {
        guard let url = endpointURL, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(location: model)
            case .failure:
                break
            }
        }
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        
        return dataTuple.character[index]
    }
    
    // MARK: - Private
    
    private func createCellViewModels() {
        
        guard let dataTuple = dataTuple else {
            return
        }
        
        let location = dataTuple.location
        let character = dataTuple.character
        
        var createdString = location.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        
        cellViewModels = [
            .info(viewModel: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModel: character.compactMap({
                return RMCharacterCollectionViewCellViewModel(characterName: $0.name,
                                                              characterStatus: $0.status,
                                                              characterImageURL: URL(string: $0.image))
            }))
        ]
    }
    
    private func fetchRelatedCharacter(location: RMLocation) {
        let requests: [RMRequest] = location.residents.compactMap {
            return URL(string: $0)
        }.compactMap {
            return RMRequest(url: $0)
        }
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (
                location: location,
                character: characters
            )
        }
    }
}
