//
//  SceneDelegate.swift
//  ItunseUserDefaults
//
//  Created by Рахим Габибли on 19.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let tabBar = TabBarController()
        let navBar = UINavigationController(rootViewController: tabBar)
        window?.rootViewController = navBar
    }
}
