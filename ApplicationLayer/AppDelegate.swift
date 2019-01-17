//
//  AppDelegate.swift
//  game_dev1
//
//  Created by Дмитрий on 14.10.15.
//  Copyright © 2015 Дмитрий. All rights reserved.
//

import UIKit
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        customizeNavBarAppearance()
        return true
    }
    
    private func customizeNavBarAppearance() {
        let attributes = [NSAttributedString.Key.font:UIFont(name: "standard 07_53", size: 19)!]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.5, alpha: 0.0)
        UINavigationBar.appearance().tintColor = UIColor(red:0.70, green:0.13, blue:0.13, alpha:1.0)
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        UINavigationBar.appearance().shadowImage = UIImage()
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: UIControl.State())
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if GlobalConstants.gameinaction == true {
            scene1!.pauseScene()
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if GlobalConstants.gameinaction == true {
            scene1!.pauseScene()
        }
    }
}
