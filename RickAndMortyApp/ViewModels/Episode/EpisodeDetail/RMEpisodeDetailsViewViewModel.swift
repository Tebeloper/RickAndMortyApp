//
//  RMEpisodeDetailsViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 28/07/2023.
//

import Foundation

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailsViewViewModel {
    
    private let endpointURL: URL?
    
    private var dataTuple: (episode: RMEpisode, character: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case info(viewModel: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    // This property is public but ONLY for reading data
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Init
    
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
    }
    
    // MARK: - Public
    
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointURL, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(episode: model)
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
        
        let episode = dataTuple.episode
        let character = dataTuple.character
        
        var createdString = episode.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        
        cellViewModels = [
            .info(viewModel: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModel: character.compactMap({
                return RMCharacterCollectionViewCellViewModel(characterName: $0.name,
                                                              characterStatus: $0.status,
                                                              characterImageURL: URL(string: $0.image))
            }))
        ]
    }
    
    private func fetchRelatedCharacter(episode: RMEpisode) {
        let requests: [RMRequest] = episode.characters.compactMap {
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
                episode: episode,
                character: characters
            )
        }
    }
}
