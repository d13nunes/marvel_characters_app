//
//  Environment.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 21/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

struct Environment {
    let baseURL: String
    let privateKey: String
    let publicKey: String
}

fileprivate let dnunesEnv = Environment(baseURL: "https://gateway.marvel.com",
                                        privateKey: "----PRIVATE-KEY----",
                                        publicKey: "----PUBLIC-KEY----")
extension Environment {
    static let current = dnunesEnv
}

