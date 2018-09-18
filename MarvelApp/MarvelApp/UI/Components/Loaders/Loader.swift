//
//  Loader.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class Loader : UIView {
    
    let activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect) {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = Colors.activityIndicator
        activityIndicator.startAnimating()
        super.init(frame: frame)
    
        addSubview(activityIndicator)
    }
    
    convenience init(frame: CGRect, dimmedBackground: Bool = true) {
        self.init(frame: frame)
        if  dimmedBackground {
            backgroundColor = UIColor.black.withAlphaComponent(0.333)
        } else {
            backgroundColor = UIColor.clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.center = center
    }
}
