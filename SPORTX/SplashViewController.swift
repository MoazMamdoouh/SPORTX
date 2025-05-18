//
//  SplashViewController.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 18/05/2025.
//

import Lottie
import UIKit

class SplashViewController: UIViewController {
    var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottie()

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.navigateToNextScreen()
        }
    }

    private func navigateToNextScreen() {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        print(isFirstLaunch)
        guard let myStoryboard = self.storyboard else { return }


        let nextVC: UIViewController = myStoryboard.instantiateViewController(identifier: "Tabbar")

        // MARK: do after using onBoarding
        
//        if isFirstLaunch {
//            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
//            nextVC = myStoryboard.instantiateViewController(identifier: "OnBoarding")
//        } else {
//            nextVC = myStoryboard.instantiateViewController(identifier: "Tabbar")
//        }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = nextVC
            window.makeKeyAndVisible()

            let transition = CATransition()
            transition.type = .fade
            transition.duration = 0.3
            window.layer.add(transition, forKey: kCATransition)
        }
    }

    private func setupLottie() {
        animationView = LottieAnimationView(name: "splash_animation")
        guard let animationView else { return }
        view.backgroundColor = .systemBackground
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .autoReverse
        animationView.animationSpeed = 1.3
        view.addSubview(animationView)
        animationView.play()
    }
}
