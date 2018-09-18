//
//  VitrineView.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 20/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class ShowcaseView: UIView {
    
    private let titleLabel = UILabel()
    private let showcase = UIStackView()
    var itemSize = CGSize(width: 80, height: 140) {
        didSet {
            showcase.heightAnchor.constraint(equalToConstant: itemSize.height).isActive = true
        }
    }
    
    var numberOfItemToShow: Int = 3
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView()  {
        setupTitle()
        setupShowcase()
    }
    
    private func setupTitle()  {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func setupShowcase()  {
        showcase.axis = .horizontal
        showcase.alignment = .leading
        showcase.distribution = .fillProportionally
        showcase.spacing = 20
        showcase.heightAnchor.constraint(equalToConstant: itemSize.height).isActive = true
        addSubview(showcase)
        showcase.translatesAutoresizingMaskIntoConstraints = false
        showcase.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        showcase.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        showcase.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        showcase.heightAnchor.constraint(equalToConstant: itemSize.height).isActive = true
        showcase.topAnchor.constraint(equalTo:  titleLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    func set(title: String, vms: [HeroItemViewModelProtocol])  {
        titleLabel.text = title
        
        let firstVMs = vms.prefix(numberOfItemToShow)

        for vm in firstVMs {
            let view = ShowcaseItem(frame: CGRect(origin: CGPoint.zero, size:  itemSize))
            view.set(vm: vm)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: itemSize.width).isActive = true
            view.heightAnchor.constraint(equalToConstant: itemSize.height).isActive = true
            showcase.addArrangedSubview(view)
        }
    }
}
