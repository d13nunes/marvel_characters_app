//
//  HeroDetailViewModelProtocol.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 20/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

protocol HeroDetailViewModelProtocol : BaseViewModelProtocol {
    
    var state: HeroDetailState { get }
    
    var stateChanged: ((HeroDetailState) -> Void)? { get }
    func set(favourite: Bool);
}

struct HeroDetailState {
    let hero: Hero
    let isFavourite: Bool
    let comicsVMs: [HeroItemViewModelProtocol]
    let eventsVMs: [HeroItemViewModelProtocol]
    let storiesVMs: [HeroItemViewModelProtocol]
    let seriesVMs: [HeroItemViewModelProtocol]
}
