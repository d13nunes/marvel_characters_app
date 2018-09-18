//
//  ComicsRequest.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class CharacterResourseRequest: BaseRequest {
    var environment: Environment
    var session = URLSession.shared
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func request(resourceURI: String, completion: @escaping (CharacterResource?, Error?)->Void) -> URLSessionTask
    {
        return genericRequest(ulrString: resourceURI, queryItems: []) { (response: DTOS.CharactersResponse?, error) in
            guard nil == error else {
                completion(nil, error)
                return
            }
            if  let charactersResponse = response {
                if let dto = charactersResponse.data?.results?.first   {
                    let comic = CharacterResourseRequest.characterResource(from: dto)
                    completion(comic, nil)
                    return
                    
                }
            }
            completion(nil, nil)
        }
    }
    
    
    private static func characterResource(from: DTOS.Result) -> CharacterResource {
        return CharacterResource(id: String(from.id!), name: from.name ?? "", thumbnail: from.thumbnail?.toThumbnail()  )
    }
    
}


extension DTOS.Thumbnail {
    func toThumbnail() -> Thumbnail? {
        if let aPath = path {
            return Thumbnail(
                path: aPath,
                thumbnailExtension: self.thumbnailExtension ?? "jpg"
            )
        }
        return nil
    }
}
