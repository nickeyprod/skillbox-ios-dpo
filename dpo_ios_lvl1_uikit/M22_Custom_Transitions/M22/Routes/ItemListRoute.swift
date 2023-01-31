import UIKit

protocol ItemListRoute {
    func makeItemList() -> UIViewController
}

extension ItemListRoute where Self: Router {
    func makeItemList() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = ItemListViewModel(router: router)
        let viewController = ItemListViewController(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 0)
        return navigation
    }

    func selectListTab() {
        root?.tabBarController?.selectedIndex = 0
    }
    
    func makeItemList2() -> UIViewController {
        let router = DefaultRouter(rootTransition: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
        let viewModel = ItemListViewModel2(router: router)
        let viewController = ItemListViewController2(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: "New Transition", image: nil, tag: 0)
        return navigation
    }

    func selectListTab2() {
        root?.tabBarController?.selectedIndex = 1
    }
}

extension DefaultRouter: ItemListRoute {}
