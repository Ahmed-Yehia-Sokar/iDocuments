//
//  AppDelegate.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - properties
    
    var window: UIWindow?
    
    // MARK: - methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

