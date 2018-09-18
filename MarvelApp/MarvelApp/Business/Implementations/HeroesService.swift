//
//  HeroList.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 21/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
class HeroesService: HeroesServiceProtocol {
    
    let charactersRequest = CharactersRequest(environment: Environment.current )
    
    func fetch(offset: Int, limit: Int, name: String?, onCompletion completion: @escaping ([Hero], Int, Error?) -> Void) -> URLSessionTask {
        let task = charactersRequest.request(offset: offset, limit: limit, name: name) { heroes, totalHeroes, error in
            completion(heroes, totalHeroes, error)
        }
        return task
    }
}
