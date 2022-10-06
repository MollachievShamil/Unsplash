//
//  DetailsPresenter.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
}

protocol DetailsPresenterProtocol: AnyObject {
}

class DetailsPresenter: DetailsPresenterProtocol {
  
    weak var view: DetailsViewProtocol?
    let router: RouterProtocol
    var storage: StorageProtocol
    
    init(view: DetailsViewProtocol, router: RouterProtocol, storage: StorageProtocol) {
        self.view = view
        self.router = router
        self.storage = storage
    }
}
