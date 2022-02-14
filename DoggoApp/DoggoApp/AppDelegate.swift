//
//  AppDelegate.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 11/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startCoordinator()
        return true
    }

    func startCoordinator() {
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

