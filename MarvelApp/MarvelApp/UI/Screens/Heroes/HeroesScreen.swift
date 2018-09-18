//
//  HeroListScreen.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 17/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class HeroesScreen: BaseViewController {
    
    var viewmodel: HeroesViewModelProtocol
    
    @IBOutlet weak var heroCollectionView: UICollectionView!
    @IBOutlet weak var loadingMoreView: UIView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HeroesScreen.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = Colors.activityIndicator
        return refreshControl
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.textContentType = UITextContentType.name
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.returnKeyType = .done
        return searchController
    }()
    
    private lazy var heroesDataSource: HeroesDataSource = {
        return HeroesDataSource(favouriteHeroesSerice: FavouritesService())
    }()
    
    private lazy var heroesDelegate: HeroesDelegate = {
        return HeroesDelegate(onHeroSelection: heroSelected,
                                        onLoadMoreHeroes: loadMoreHeros)
    }()
    
    private var nameToSearch: String?
    
    convenience init(withViewmodel viewmodel: HeroesViewModel) {
        self.init(withViewmodel: viewmodel, nibName: "HeroesScreen")
    }
    
    required init(withViewmodel viewmodel: HeroesViewModel, nibName: String) {
        self.viewmodel = viewmodel
        super.init(nibName: nibName, bundle: nil)
        self.viewmodel.stateChanged = {
            self.updateToNewState(state: viewmodel.state)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
        setupNavigationBar()
        setupCollectionView()
        nameToSearch = nil
        
        viewmodel.refresh(searchName: nameToSearch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateToNewState(state: viewmodel.state)
    }
    
    func setupNavigationBar()  {
        navigationItem.title = "Marvel Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = Colors.marvelRed
    }
    
    func setupCollectionView()  {
        heroCollectionView.register(HeroCollectionCell.nib, forCellWithReuseIdentifier: HeroCollectionCell.id)
        heroCollectionView.dataSource = heroesDataSource
        heroCollectionView.delegate = heroesDelegate
        heroCollectionView.refreshControl = refreshControl
        heroCollectionView.backgroundColor = UIColor.clear
        heroCollectionView.contentInsetAdjustmentBehavior = .always
        edgesForExtendedLayout = .all
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewmodel.refresh(searchName: nameToSearch)
    }
    
    func updateToNewState(state: HeroesViewModelState)  {
        heroesDataSource.heroes = state.heroes
        heroCollectionView.reloadData()
        
        if state.isLoading {
            ProgressLoader.shared.show(on: view)
        } else {
            ProgressLoader.shared.remove(from: view)
        }
        
        if state.isLoadingMore {
            Animator.animate(animations: { self.loadingMoreView.alpha = 1.0 })
        } else {
            Animator.animate(animations: { self.loadingMoreView.alpha = 0.0 })
            refreshControl.endRefreshing()
        }
        
        if let errorMessage = state.errorMessage {
            let alerDialog = Dialogs.errorDailog(errorMessage: errorMessage)
            self.present(alerDialog, animated: true, completion: nil)
        }
    }
    
    func search(for nameOrNil: String?)  {
        if nameToSearch != nameOrNil {
            nameToSearch = nameOrNil
            viewmodel.refresh(searchName: nameToSearch)
        }
    }
    
    func loadMoreHeros() {
        if viewmodel.state.hasMoreToLoad {
            viewmodel.loadMore(searchName: nameToSearch)
        }
    }
    
    private func heroSelected(at index: Int)  {
        let hero = viewmodel.state.heroes[index]
        let heroDetailScreen = ScreenFactory.create(screenNamed: .heroDetail, parameter: hero)
        self.navigationController?.pushViewController(heroDetailScreen, animated: true)
    }
}
