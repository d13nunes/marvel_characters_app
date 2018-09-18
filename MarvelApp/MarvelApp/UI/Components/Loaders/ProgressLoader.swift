//
//  ProgressLoader.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 18/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class ProgressLoader {
    static let shared = ProgressLoader()
    private static let defaultTag = 1988021820181001
    
    func show(on view: UIView, dimmedBackground: Bool = true)  {
        //if a ProgressLoader view exists ignore
        guard nil == findLoaderView(on: view) else {
            return
        }
        
        let loaderView = Loader(frame:view.bounds, dimmedBackground: dimmedBackground)
        loaderView.tag = ProgressLoader.defaultTag
        loaderView.alpha = 0
        view.addSubview(loaderView)
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loaderView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.bringSubview(toFront: loaderView)
        
        Animator.animate(animations: {
            loaderView.alpha = 1
        })
    }
    
    
    func remove(from view: UIView) {
        if let loaderView = findLoaderView(on: view) {
            Animator.animate(animations: {
                loaderView.alpha = 0
            }) { _ in
                loaderView.removeFromSuperview()
            }
        } else {
            debugPrint("no loaderview to be removed")
        }
    }
    
    private func findLoaderView(on view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.tag == ProgressLoader.defaultTag {
                return subview
            }
        }
        return nil
    }
}


extension UIView {
    func showLoader(dimmedBackground: Bool = true)  {
        ProgressLoader.shared.show(on: self, dimmedBackground: dimmedBackground)
    }
    func removeLoader(dimmedBackground: Bool = true) {
        ProgressLoader.shared.remove(from: self)
    }
}
