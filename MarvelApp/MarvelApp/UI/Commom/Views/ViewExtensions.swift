//
//  ViewExtensions.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 20/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func  addGradient(colors: [CGColor]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
