//
//  SceneDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/14/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController(rootViewController: AppointmentListViewController())

        navigationController.navigationBar.prefersLargeTitles = true

        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()
    }
}
