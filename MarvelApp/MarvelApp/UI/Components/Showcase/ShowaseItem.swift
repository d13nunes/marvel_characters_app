//
//  ShowaseItem.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 20/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class ShowcaseItem: UIView {
    
    let imageView = URLImageView()
    let titleLabel = UILabel()
    var imageGradient: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShowcaseItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShowcaseItem()  {
        setupImageView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageGradient = imageView.addGradient(colors: GradientColors.image)
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        titleLabel.textColor = UIColor.white
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageGradient?.frame = bounds
    }
    
    func set(vm: HeroItemViewModelProtocol) {
        titleLabel.text = vm.state.heroItem.name
        titleLabel.sizeToFit()
        
        showLoader()
        vm.load (){ (_) in
            DispatchQueue.main.async {
                if let imageUrl = vm.state.imageURL {
                    self.imageView.setImage(from: imageUrl)
                }
                self.removeLoader()
            }
        }
    }
}
