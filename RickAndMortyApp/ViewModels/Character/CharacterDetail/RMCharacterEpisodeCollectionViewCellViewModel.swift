//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 27/07/2023.
//

import UIKit

protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {
    
    private let episodeDataURL: URL?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    public let borderColor: UIColor
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            self.dataBlock?(model)
        }
    }
    
    // MARK: - Init
    
    init(episodeDataURL: URL?, borderColor: UIColor = .systemBlue) {
        self.episodeDataURL = episodeDataURL
        self.borderColor = borderColor
    }
    
    // MARK: - Public
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisodes() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataURL, let rmRequest = RMRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(rmRequest,
                                 expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print((failure))
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataURL?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodeCollectionViewCellViewModel, rhs: RMCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
