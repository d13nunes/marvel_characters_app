//
//  HeroesDataSource.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import UIKit

class HeroesDataSource: NSObject, UICollectionViewDataSource {
    
    let favouriteHeroesSerice: FavouritesServiceProtocol
    var heroes: [Hero] = []
    
    required init(favouriteHeroesSerice: FavouritesServiceProtocol) {
        self.favouriteHeroesSerice = favouriteHeroesSerice
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionCell.id,
                                                      for: indexPath)
            as? HeroCollectionCell
        if let cell = cell {
            let hero = heroes[indexPath.row]
            let isFav = favouriteHeroesSerice.isFavourite(hero: hero)
            cell.update(hero, isFavourite: isFav) { (isFavourite) in
                self.favouriteHeroesSerice.set(favourite: isFavourite, hero: hero)
            }
            return cell
        }
        fatalError("Cell Should Not be Null")
    }
}
