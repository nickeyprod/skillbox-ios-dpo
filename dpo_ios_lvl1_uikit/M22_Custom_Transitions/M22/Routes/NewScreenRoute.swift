//
//  NewScreenRoute.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//
import UIKit

protocol NewScreenRoute {
    func openNewScreen()
}

extension NewScreenRoute where Self: Router {
    func openNewScreen(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = NewScreenModel(router: router)
        let viewController = NewScreenViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController

        route(to: navigationController, as: transition)
    }

    func openNewScreen() {
        openNewScreen(with: AnimatedTransition2(animatedTransition: PictureTransitioning()))
    }
}

extension DefaultRouter: NewScreenRoute {}
