//
//  Comics.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
extension DTOS {
struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ItemSummary]?
    let returned: Int?
}
}
