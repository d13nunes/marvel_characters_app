//
//  HeroDetailScreen.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 18/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailScreen: BaseViewController {
    let viewmodel: HeroDetailViewModelProtocol
    
    @IBOutlet weak var favouriteButton: FavouriteButton!
    @IBOutlet weak var comicsShowcase: ShowcaseView!
    @IBOutlet weak var eventsShowcase: ShowcaseView!
    @IBOutlet weak var seriesShowcase: ShowcaseView!
    @IBOutlet weak var storiesShowcase: ShowcaseView!
    @IBOutlet weak var heroImageView: URLImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init(viewmodel: HeroDetailViewModelProtocol) {
        
        self.viewmodel = viewmodel
        super.init(nibName: "HeroDetailScreen", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFor(state: viewmodel.state)
        
    }
    
    private func updateFor(state: HeroDetailState)  {
        title = state.hero.name
        heroImageView.setImage(fromThumbnail: state.hero.thumbnail, orientation: .landscape)
        
        comicsShowcase.isHidden = state.comicsVMs.isEmpty
        comicsShowcase.set(title: "Comics", vms: state.comicsVMs)
        
        eventsShowcase.isHidden = state.eventsVMs.isEmpty
        eventsShowcase.set(title: "Events", vms: state.eventsVMs)
        
        seriesShowcase.isHidden = state.seriesVMs.isEmpty
        seriesShowcase.set(title: "Series", vms: state.seriesVMs)
        
        storiesShowcase.isHidden = state.storiesVMs.isEmpty
        storiesShowcase.set(title: "Stories", vms: state.storiesVMs)
        
        descriptionLabel.text = state.hero.description
       
        favouriteButton.isFavourite = state.isFavourite
        favouriteButton.onStateChanged = onFavouriteChanged
    }
    
    private func onFavouriteChanged(isFav: Bool)  {
        viewmodel.set(favourite: isFav)
    }
    
}
