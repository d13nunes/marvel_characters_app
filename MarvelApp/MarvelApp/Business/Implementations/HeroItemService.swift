//
//  HeroItemService.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class HeroItemService: HeroItemServiceProtocol {
    
    let requester: CharacterResourseRequest
    
    init(environment: Environment) {
        requester = CharacterResourseRequest(environment: environment)
    }
    
    func fetchImage(resourceURI: String, completion: @escaping (URL?, Error?) -> Void) -> URLSessionTask {
        return requester.request(resourceURI: resourceURI) { (comic, error) in
            completion(comic?.thumbnail?.toURL(orientation: .portrait), error)
        }
    }
}
