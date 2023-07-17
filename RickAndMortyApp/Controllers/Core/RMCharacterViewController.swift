//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
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
