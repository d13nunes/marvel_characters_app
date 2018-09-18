//
//  HeroItemViewModelProtocol.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

protocol HeroItemViewModelProtocol : BaseViewModelProtocol{
    var state: HeroItemViewModelState { get }
    func load(completion: @escaping (Error?) -> Void);
}

struct HeroItemViewModelState {
    let heroItem: HeroItem
    let imageURL: URL?
}
