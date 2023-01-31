//
//  AnimatedTransition2.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//

import UIKit

final class AnimatedTransition2: NSObject {
    let animatedTransition: PictureTransitioning
    var isAnimated: Bool = true

    init(animatedTransition: PictureTransitioning, isAnimated: Bool = true) {
        self.animatedTransition = animatedTransition
        self.isAnimated = isAnimated
    }
}

extension AnimatedTransition2: Transition {
    // MARK: - Transition
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        from.present(viewController, animated: isAnimated, completion: completion)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

extension AnimatedTransition2: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = true
        return animatedTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = false
        return animatedTransition
    }
}
