//
//  HeroesViewModel.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

class HeroesViewModel: HeroesViewModelProtocol {
    private let pageSize: Int = 20 ///Number of Heroes requested on each call
    
    private let heroListPresenter: HeroesServiceProtocol
    private let favouriteHeroes: FavouritesServiceProtocol
    private var currentFetchOperation: URLSessionTask?
    
    
    private var loadingCounter = 0 {
        didSet {
            if oldValue != loadingCounter {
                self.state = getUpdatedLoaderState(for: self.state)
            }
        }
    }
    
    private var loadingMoreCounter = 0 {
        didSet {
            if oldValue != loadingMoreCounter {
                self.state = getUpdatedLoaderState(for: self.state)
            }
        }
    }
    
    var state: HeroesViewModelState
    {
        didSet {
            if oldValue != state {
                DispatchQueue.main.async {
                    self.stateChanged?()
                }
            }
        }
    }
    var stateChanged: (() -> Void)?
    
    init(withHeroList heroListPresenter: HeroesServiceProtocol,
         withFavouritesHeroes favouriteHeroesPresenter: FavouritesServiceProtocol) {
        
        self.heroListPresenter = heroListPresenter
        self.favouriteHeroes = favouriteHeroesPresenter
        state = HeroesViewModelState(
            hasMoreToLoad: false,
            heroes: [],
            isLoading: self.loadingCounter > 0,
            isLoadingMore: self.loadingMoreCounter > 0,
            errorMessage: nil
        )
    }
    
    func refresh(searchName name: String?) {
        loadingCounter += 1
        currentFetchOperation?.cancel()
        currentFetchOperation = heroListPresenter.fetch(offset: 0, limit: pageSize, name: name) {
            (heroes, totalHeroes, error) in
            self.loadingCounter -= 1
            if let error = error as NSError? {
                if error.code != NSURLErrorCancelled {
                    self.state = HeroesViewModelState(
                        hasMoreToLoad: false,
                        heroes: [],
                        isLoading: self.loadingCounter > 0,
                        isLoadingMore: self.loadingMoreCounter > 0,
                        errorMessage: error.localizedDescription
                    )
                }
            } else {
                self.state = HeroesViewModelState(
                    hasMoreToLoad: heroes.count < totalHeroes,
                    heroes: heroes,
                    isLoading: self.loadingCounter > 0,
                    isLoadingMore: self.loadingMoreCounter > 0,
                    errorMessage: error?.localizedDescription
                )
            }
            
        }
    }
    
    func loadMore(searchName name: String?) {
        if let currentFetchOperation =  currentFetchOperation?.state,
            currentFetchOperation == .running {
            return
        }
        loadingMoreCounter += 1
        let offset = state.heroes.count
        currentFetchOperation =  heroListPresenter.fetch(offset: offset, limit: pageSize, name: name) {
            (heroes, totalHeroes, error) in
            self.loadingMoreCounter -= 1
            if let error = error as NSError? {
                if error.code != NSURLErrorCancelled {
                    self.state = HeroesViewModelState(
                        hasMoreToLoad: false,
                        heroes: [],
                        isLoading: self.loadingCounter > 0,
                        isLoadingMore: self.loadingMoreCounter > 0,
                        errorMessage: nil
                    )
                }
            } else {
                let nHeroes = self.state.heroes + heroes
                self.state = HeroesViewModelState(
                    hasMoreToLoad: nHeroes.count < totalHeroes,
                    heroes: nHeroes,
                    isLoading: self.loadingCounter > 0,
                    isLoadingMore: self.loadingMoreCounter > 0,
                    errorMessage: nil
                )
            }
        }
    }
    
    private func getUpdatedLoaderState(for state: HeroesViewModelState) -> HeroesViewModelState {
        return HeroesViewModelState(
            hasMoreToLoad: state.hasMoreToLoad,
            heroes: state.heroes,
            isLoading: loadingCounter > 0,
            isLoadingMore: loadingMoreCounter > 0,
            errorMessage: state.errorMessage)
    }
    
}
