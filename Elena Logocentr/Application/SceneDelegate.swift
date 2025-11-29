//
//  SceneDelegate.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 21/11/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        

        window = UIWindow(windowScene: windowScene)
        
        /*if isUserReistered {
            
        } else { */
            let navigationViewController = UINavigationController(rootViewController: SignInViewController())
            window?.rootViewController = navigationViewController
        
        
  
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

