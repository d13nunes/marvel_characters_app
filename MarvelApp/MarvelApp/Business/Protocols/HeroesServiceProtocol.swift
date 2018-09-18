//
//  HeroListPresenter.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

protocol HeroesServiceProtocol {
    func fetch(offset: Int, limit: Int, name: String?, onCompletion completion:  @escaping (_ heroes: [Hero], _ totalHeroes: Int, _ error: Error?) -> Void) -> URLSessionTask;
}
