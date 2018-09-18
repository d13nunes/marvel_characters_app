//
//  HeroesViewModel.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

protocol HeroesViewModelProtocol : BaseViewModelProtocol{
    
    var state: HeroesViewModelState  { get }
    
    var stateChanged: (() -> Void)? { get set}
    
    func refresh(searchName name: String?);
    func loadMore(searchName name: String?);
}

struct HeroesViewModelState: Equatable {
    let hasMoreToLoad: Bool
    let heroes: [Hero]
    let isLoading: Bool
    let isLoadingMore: Bool
    let errorMessage: String?
}
