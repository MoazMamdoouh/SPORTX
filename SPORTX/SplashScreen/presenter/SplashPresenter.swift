//
//  SplashPresenter.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 18/05/2025.
//

import UIKit

protocol SplashPresenterProtocol {
    func getNextScreen(storyboard: UIStoryboard) -> UIViewController
}

class SplashPresenter: SplashPresenterProtocol {
    static let hasLaunchedBeforeKey = "hasLaunchedBefore"
    func getNextScreen(storyboard: UIStoryboard) -> UIViewController {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: SplashPresenter.hasLaunchedBeforeKey)
        if isFirstLaunch {
            // MARK: do after using onBoarding

            UserDefaults.standard.set(true, forKey: SplashPresenter.hasLaunchedBeforeKey)
//            nextVC = myStoryboard.instantiateViewController(identifier: "OnBoarding")
            let nextVC = storyboard.instantiateViewController(identifier: "Tabbar")

            return nextVC
        } else {
            guard let tabBarController = storyboard.instantiateViewController(identifier: "Tabbar") as? UITabBarController else { return UIViewController() }
            _ = tabBarController.view

            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor(resource: .blackwhitecolor)], for: .selected)

            if let tabBarItems = tabBarController.tabBar.items {
                tabBarItems[0].title = NSLocalizedString("home", comment: "home")

                tabBarItems[0].image = resizeImage(named: "football_uncolored_field", to: CGSize(width: 25, height: 25))
                tabBarItems[0].selectedImage = resizeImage(named: "football_colored_field", to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)

                tabBarItems[1].title = NSLocalizedString("favorite", comment: "favorite")
                tabBarItems[1].image = resizeImage(named: "fav_uncolored", to: CGSize(width: 25, height: 25))
                tabBarItems[1].selectedImage = resizeImage(named: "fav_colored", to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
            }
            return tabBarController
        }
    }

    private func resizeImage(named name: String, to size: CGSize) -> UIImage? {
        guard let image = UIImage(named: name) else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
