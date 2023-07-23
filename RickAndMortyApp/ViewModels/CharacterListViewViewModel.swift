//
//  CharacterListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 23/07/2023.
//

import UIKit

final class CharacterListViewViewModel: NSObject {
    
    func fetchCharacter() {
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case(.success(let data)):
                print("Total:"+String(data.info.count))
                print("Page result count:"+String(data.results.count))
            case(.failure(let error)):
                print(error)
            }
        }
        
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
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
