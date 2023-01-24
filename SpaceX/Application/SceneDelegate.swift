//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let paramModel = ParametersModel()
        let userSettings = UserSettings()
        var settingsArray = [true, true, true, true]
        settingsArray = userSettings.loadSettings()
        if settingsArray.count > 0 {
            for i in 0...settingsArray.count - 1  {
                paramModel.items[i].isFirstParameter = settingsArray[i]
            }
        }
        let startModule = RocketsRouter.createModule(paramModel: paramModel)
        let navigationController = UINavigationController(rootViewController: startModule)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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

