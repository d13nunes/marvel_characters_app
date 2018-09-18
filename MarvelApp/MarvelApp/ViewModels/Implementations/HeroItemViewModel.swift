//
//  HeroItemViewModel.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class HeroItemViewModel: HeroItemViewModelProtocol {
    
    private let heroItemService: HeroItemServiceProtocol
    
    var state: HeroItemViewModelState
    
    
    init(heroItem: HeroItem, heroItemService: HeroItemServiceProtocol) {
        self.heroItemService = heroItemService
        state = HeroItemViewModelState (
            heroItem: heroItem,
            imageURL: nil
        )
    }
    
    func load(completion: @escaping (Error?) -> Void) {
        state = HeroItemViewModelState (
            heroItem: state.heroItem,
            imageURL: state.imageURL
        )
        _ = heroItemService.fetchImage(resourceURI: state.heroItem.resourceURI) { (url, error) in
            self.state = HeroItemViewModelState (
                heroItem: self.state.heroItem,
                imageURL: url
            )
            completion(error)
        }
    }
}
