//
//  HeroDetailViewModel.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 20/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class HeroDetailViewModel: HeroDetailViewModelProtocol {
    
    var state: HeroDetailState {
        didSet {
            stateChanged?(state)
        }
    }
    
    var stateChanged: ((HeroDetailState) -> Void)?
    
    private let favouriteHeroes: FavouritesServiceProtocol
    
    init(hero: Hero, withFavouritesHeroes favouriteHeroesPresenter: FavouritesServiceProtocol) {
        self.favouriteHeroes = favouriteHeroesPresenter
        
        let isFavourite = self.favouriteHeroes.isFavourite(hero: hero)
        
        state = HeroDetailState (
            hero: hero,
            isFavourite: isFavourite,
            comicsVMs: hero.comics.map(HeroDetailViewModel.heroItemViewModel),
            eventsVMs: hero.events.map(HeroDetailViewModel.heroItemViewModel),
            storiesVMs: hero.stories.map(HeroDetailViewModel.heroItemViewModel),
            seriesVMs: hero.series.map(HeroDetailViewModel.heroItemViewModel)
        )
    }
    
    func set(favourite: Bool) {
        favouriteHeroes.set(favourite: favourite, hero: state.hero)
        state = HeroDetailState (
            hero: state.hero,
            isFavourite: favourite,
            comicsVMs: state.comicsVMs,
            eventsVMs: state.eventsVMs,
            storiesVMs: state.storiesVMs,
            seriesVMs: state.seriesVMs
        )
    }
    
    private static func heroItemViewModel (from hero: HeroItem) -> HeroItemViewModel {
        return HeroItemViewModel(heroItem: hero, heroItemService: HeroItemService(environment: Environment.current))
    }
}
