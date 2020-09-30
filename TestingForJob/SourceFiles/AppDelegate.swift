//
//  AppDelegate.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate { 
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let currentVC = GeneralViewController()
        let navigationController = UINavigationController(rootViewController: currentVC)
        navigationController.navigationBar.shadowImage = UIImage()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        return true
    }
    
}


