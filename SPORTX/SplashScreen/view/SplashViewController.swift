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
    var presenter : SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottie()
        presenter = SplashPresenter()

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.navigateToNextScreen()
        }
    }

    private func navigateToNextScreen() {
        
        guard let myStoryboard = self.storyboard, let presenter = presenter else { return }

        let nextVC: UIViewController = presenter.getNextScreen(storyboard: myStoryboard)
                
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
