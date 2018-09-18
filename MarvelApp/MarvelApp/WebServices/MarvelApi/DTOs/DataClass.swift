//
//  DataClass.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//
extension DTOS {
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Result]?
    }}
