//
//  CharactersResponse.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

enum DTOS {}


extension DTOS {
    struct CharactersResponse: Codable {
        let code: Int?
        let status, copyright, attributionText, attributionHTML: String?
        let etag: String?
        let data: DataClass?
    }
}
