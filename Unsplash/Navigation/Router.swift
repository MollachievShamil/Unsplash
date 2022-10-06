//  Router.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get }
    func showDetailsViewController()
    func pop()
}

class Router: RouterProtocol {
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = navigationController
    }
    
    var navigationController: UINavigationController
    var viewControllerFactory: ViewControllerFactoryProtocol?

    func showDetailsViewController() {
        guard let componentViewController = viewControllerFactory?.createDetailsViewController(router: self) else { return }
        navigationController.pushViewController(componentViewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
