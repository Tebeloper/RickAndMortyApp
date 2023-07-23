//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 23/07/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageURL: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText: String {
        return characterStatus.rawValue
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        
        // ToDo: Abstract to Image Manager
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
}
