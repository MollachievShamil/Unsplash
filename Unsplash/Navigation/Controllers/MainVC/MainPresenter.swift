//
//  MainPresenter.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
}

protocol MainPresenterProtocol: AnyObject {

}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let router: RouterProtocol
    var networkService: NetworkingProtocol
    
    init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkingProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
}
