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
        let viewModel = ListViewModel()
        sceneCoordinator.transition(to: .list(viewModel), type: .root, animated: false)
        return true
    }
}
