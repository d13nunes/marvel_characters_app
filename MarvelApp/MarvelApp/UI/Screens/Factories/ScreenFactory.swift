//
//  ScreenFactory.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 20/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

enum ScreenName {
    case heroes
    case heroDetail
}


class ScreenFactory {
    static func create(screenNamed: ScreenName, parameter: Any? = nil) -> UIViewController{
        switch screenNamed {
        case .heroes:
            let vm = HeroesViewModel(withHeroList: HeroesService(), withFavouritesHeroes: FavouritesService())
            let vc = HeroesScreen(withViewmodel: vm)

            return vc
        case .heroDetail:
            let hero = parameter as? Hero
            assert(hero != nil)
            let vm = HeroDetailViewModel(hero: hero!, withFavouritesHeroes: FavouritesService())
            return HeroDetailScreen(viewmodel: vm)
        }
    }
}
