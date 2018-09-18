//
//  HeroCollectionCell.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 18/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class HeroCollectionCell: UICollectionViewCell {
    static let nib = UINib(nibName: id, bundle: nil)
    static let id = "HeroCollectionCell"
    
    static let cornerRadius = CGFloat(5)
    
    @IBOutlet weak var heroImage: URLImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    
    private var hero: Hero?
    private var imageGradient: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageGradient?.frame = bounds
    }
    
    func viewSetup()  {
        
        imageGradient = heroImage.addGradient(colors: GradientColors.image)
        heroImage.layer.cornerRadius = HeroCollectionCell.cornerRadius
        heroImage.clipsToBounds = true
        heroImage.contentMode = .center
        heroName.textColor = UIColor.white
    }
    
    ///Set the cell UI with values provided by the hero object
    func update(_ hero: Hero?, isFavourite: Bool, onFavouriteChanged: @escaping (Bool)->Void)  {
        favouriteButton.isFavourite = isFavourite
        favouriteButton.onStateChanged = onFavouriteChanged
        
        self.hero = hero
        heroImage.image = UIImage()
        if let aHero = hero {
            heroImage.setImage(fromThumbnail: aHero.thumbnail, orientation: .portrait)
            heroName.text = aHero.name
        } else {
            clearUI()
        }
    }
    
    func clearUI()  {
        heroImage.image = UIImage()
        heroName.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImage.cancelLoadingImage()
    }
}

