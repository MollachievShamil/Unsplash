//
//  FavouriteImagesPresenter.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol FavoriteImagesViewProtocol: AnyObject {
}

protocol FavoriteImagesPresenterProtocol: AnyObject {
}

class FavoriteImagesPresenter: FavoriteImagesPresenterProtocol {
    weak var view: FavoriteImagesViewProtocol?
    let router: RouterProtocol
    var storage: StorageProtocol
    
    init(view: FavoriteImagesViewProtocol, router: RouterProtocol, storage: StorageProtocol) {
        self.view = view
        self.router = router
        self.storage = storage
    }
}
