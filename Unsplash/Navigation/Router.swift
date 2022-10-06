//  Router.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get }
    func showDetailsViewController(model: PhotoModel)
    func pop()
}

class Router: RouterProtocol {
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = navigationController
    }
    
    var navigationController: UINavigationController
    var viewControllerFactory: ViewControllerFactoryProtocol?

    func showDetailsViewController(model: PhotoModel) {
        guard let componentViewController = viewControllerFactory?.createDetailsViewController(router: self, model: model) else { return }
        navigationController.pushViewController(componentViewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
