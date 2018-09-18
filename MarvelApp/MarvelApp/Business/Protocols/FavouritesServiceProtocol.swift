//
//  FavouriteHeroPresenter.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//


protocol FavouritesServiceProtocol {
    func set(favourite:Bool, hero: Hero);
    func isFavourite(hero: Hero) -> Bool;
}
