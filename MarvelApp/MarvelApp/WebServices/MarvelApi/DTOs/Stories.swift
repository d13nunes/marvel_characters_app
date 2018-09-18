//
//  Stories.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//
extension DTOS {
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ItemSummary]?
    let returned: Int?
}
}
