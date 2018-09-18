//
//  MarvelNavigationController.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 19/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class MarvelNavigationController:  UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarvelNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationControllerOperation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        return NavigationControllerAnimation(operation: operation)
    }
}

class NavigationControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let springDampingRatio = CGFloat(0.60)
    let initialSprintVelocity = CGFloat(0.50)
    let operation: UINavigationControllerOperation
    init(operation: UINavigationControllerOperation) {
        self.operation = operation
        super.init()
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7555
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        if operation == .push {
            let initialFrame = CGRect(origin: CGPoint(x: 0, y: toViewController.view.bounds.height),
                                      size: toViewController.view.bounds.size)
            toViewController.view.frame = initialFrame
            containerView.addSubview(toViewController.view)
            
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: springDampingRatio, initialSpringVelocity: initialSprintVelocity, options: .curveEaseInOut, animations: {
                toViewController.view.frame = containerView.bounds
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        } else if operation == .pop {
            let initialFrame = containerView.bounds
            let finalFrame = CGRect(origin: CGPoint(x: 0, y: toViewController.view.bounds.height),
                                    size: toViewController.view.bounds.size)
            
            toViewController.view.frame = initialFrame
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: springDampingRatio, initialSpringVelocity: initialSprintVelocity, options: .curveEaseInOut, animations: {
                fromViewController.view.frame = finalFrame
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
