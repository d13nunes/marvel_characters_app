//
//  File.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import  UIKit

class FavouriteButton: UIControl {
    static let unselectedImage = UIImage.init(named: "heart_empty")
    static let selectedImage = UIImage.init(named: "heart_filled")
    
    let imageView = UIImageView()
    var isFavourite: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var onStateChanged: ((Bool)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(changeState(_:)), for: .touchUpInside)
        imageView.frame = bounds
        addSubview(imageView)
        imageView.image = FavouriteButton.unselectedImage
        backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    @objc private func changeState(_ sender: AnyClass) {
        transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.25,
                       initialSpringVelocity: 5.5,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = .identity
        },
                       completion: nil)
        isFavourite = !isFavourite
        onStateChanged?(isFavourite)
    }
    
    func updateUI()  {
        if isFavourite {
            imageView.image = FavouriteButton.selectedImage
        } else {
            imageView.image = FavouriteButton.unselectedImage
        }
    }
}
