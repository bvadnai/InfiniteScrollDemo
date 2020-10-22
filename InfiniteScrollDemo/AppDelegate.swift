//
//  AppDelegate.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 22..
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var sceneCoordinator: SceneCoordinatorProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        sceneCoordinator = SceneCoordinator(window: window!)
        sceneCoordinator.transition(to: .list, type: .root, animated: false)
        return true
    }
}
