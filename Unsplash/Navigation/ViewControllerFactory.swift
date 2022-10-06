//  ViewControllerFactory.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol ViewControllerFactoryProtocol: AnyObject {
    func createTabBar() -> UITabBarController
    func createDetailsViewController(router: RouterProtocol) -> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    private func createMainViewController() -> UIViewController {
        let view = MainViewController()
        let networkService = Networking()
        let navigationController = createNavigationViewController(controller: view, title: "Images", image: UIImage(systemName: "house.fill"))
        let router = Router(navigationController: navigationController, viewControllerFactory: self)
        let presenter = MainPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return navigationController
    }
    
    private func createFavoriteController() -> UIViewController {
        let view = FavouriteImagesViewController()
        let navigationController = createNavigationViewController(controller: view, title: "Favorite", image: UIImage(systemName: "heart.fill"))
        let router = Router(navigationController: navigationController, viewControllerFactory: self)
        let storage = Storage()
        let presenter = FavoriteImagesPresenter(view: view, router: router, storage: storage)
        view.presenter = presenter
        return navigationController
    }

    private func createNavigationViewController(controller: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = title
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }
    
    func createTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        let mainViewController = createMainViewController()
        let favoriteViewController = createFavoriteController()
        tabBarController.viewControllers = [mainViewController, favoriteViewController]
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.barTintColor = .white
        return tabBarController
    }
    
    func createDetailsViewController(router: RouterProtocol) -> UIViewController {
        let view = DetailsViewController()
        let storage = Storage()
        let presenter = DetailsPresenter(view: view, router: router, storage: storage)
        view.presenter = presenter
        return view
    }
}
