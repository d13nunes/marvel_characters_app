//
//  HeroItemServiceProtocol.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
protocol HeroItemServiceProtocol {
    func fetchImage(resourceURI: String, completion: @escaping (URL?, Error?) -> Void) -> URLSessionTask;
}
