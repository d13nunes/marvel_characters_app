//
//  Result.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//
extension DTOS {
struct Result: Codable {
    let id: Int?
    let name, description: String?
    let thumbnail: Thumbnail?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
}
}
