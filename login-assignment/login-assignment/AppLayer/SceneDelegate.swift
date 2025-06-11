//
//  SceneDelegate.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return }
        let window: UIWindow = UIWindow(windowScene: windowScene)
        
        let preferenceRepository: PreferenceRepository = UserDefaultsPreferenceRepository()
        let startNavigationUseCase: StartNavigationUseCase = StartNavigationUseCase(preferenceRepository: preferenceRepository)
        let startViewModel: StartViewModel = StartViewModel(navigationUseCase: startNavigationUseCase)
        let startViewController: StartViewController = StartViewController(viewModel: startViewModel)
        let navigation: UINavigationController = UINavigationController(rootViewController: startViewController)
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
