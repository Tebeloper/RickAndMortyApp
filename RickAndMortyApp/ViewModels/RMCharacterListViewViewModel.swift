//
//  CharacterListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 23/07/2023.
//

import UIKit

final class RMCharacterListViewViewModel: NSObject {
    
    func fetchCharacter() {
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case(.success(let data)):
                print("Example image URL:"+String(data.results.first?.image ?? "No Image"))
            case(.failure(let error)):
                print(error)
            }
        }
        
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(
            characterName: "Tebeloper",
            characterStatus: .alive,
            characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
        )
        
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width*1.5
        )
    }
    
}
