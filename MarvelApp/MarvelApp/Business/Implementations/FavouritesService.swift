//
//  FavouriteHeroCoreData.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class FavouritesService: FavouritesServiceProtocol {
   
    func set(favourite: Bool, hero: Hero) {
        if favourite {
            addToFavourites(hero: hero)
        } else {
            removeFromFavourites(hero: hero)
        }
    }
    
    func isFavourite(hero: Hero) -> Bool {
        let isFav = UserDefaults.standard.bool(forKey: hero.id)
        return isFav
    }
    
    private func addToFavourites(hero: Hero) {
        UserDefaults.standard.set(true, forKey: hero.id)
    }
    
    private func removeFromFavourites(hero: Hero) {
        UserDefaults.standard.removeObject(forKey: hero.id)
    }
}
