//
//  Hero.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 17/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

struct Hero: Equatable {
    let id: String
    let name: String
    let description: String
    let thumbnail: Thumbnail?
    
    let comics: [HeroItem]
    let series: [HeroItem]
    let stories: [HeroItem]
    let events: [HeroItem]

    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return lhs.id == rhs.id
    }
}


