//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 17/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let firstViewController = ScreenFactory.create(screenNamed: .heroes)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MarvelNavigationController(rootViewController: firstViewController)
        window?.makeKeyAndVisible()
        setupNavigationUI()
        return true
    }
    
    func setupNavigationUI()
    {
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = Colors.marvelRed
    }
}
