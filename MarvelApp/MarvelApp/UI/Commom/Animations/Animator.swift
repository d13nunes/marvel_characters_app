//
//  Animator.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import  UIKit

class Animator {
    static func animate(animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.333,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: completion)
    }
}
