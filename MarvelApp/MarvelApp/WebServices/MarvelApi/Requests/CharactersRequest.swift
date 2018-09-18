//
//  Request.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 21/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class CharactersRequest: BaseRequest  {
    
    var environment: Environment
    var session = URLSession.shared
    private let path = "/v1/public/characters"
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func request(offset: Int, limit: Int, name: String? ,completion: @escaping (_ heroes: [Hero], _ totalHeroes: Int, _ error: Error?)->Void) -> URLSessionTask {
        var queryItems = [URLQueryItem(name: "limit", value: String(limit)),
                          URLQueryItem(name: "offset", value: String(offset))]
        if let aName = name {
            queryItems.append(URLQueryItem(name: "nameStartsWith", value: aName))
        }
        
        return genericRequest(path: path, queryItems: queryItems) { (response: DTOS.CharactersResponse?, error) in
            guard nil == error else {
                completion([], 0, error)
                return
            }
            if  let charactersResponse = response {
                if let characters = charactersResponse.data?.results   {
                    let heroes = characters.map(CharactersRequest.characterToHero)
                    completion(heroes, charactersResponse.data?.total ?? 0 , nil)
                    return
                }
            }
            completion([], 0, nil)
        }
    }
    
    private static func characterToHero(_ character: DTOS.Result) -> Hero {
        return Hero(id:character.id!.description, name: character.name!, description: character.description ?? "",
                    thumbnail:  character.thumbnail?.toThumbnail() ?? nil,
                    comics: character.comics?.items?.map(itemSummaryToHeroItemSummary) ?? [],
                    series: character.series?.items?.map(itemSummaryToHeroItemSummary) ?? [],
                    stories: character.stories?.items?.map(itemSummaryToHeroItemSummary) ?? [],
                    events: character.events?.items?.map(itemSummaryToHeroItemSummary) ?? [])
    }
    
    private static func itemSummaryToHeroItemSummary(item: DTOS.ItemSummary) -> HeroItem{
        return HeroItem(
            resourceURI: item.resourceURI ?? "",
            name: item.name ?? ""
        )
    }
}
