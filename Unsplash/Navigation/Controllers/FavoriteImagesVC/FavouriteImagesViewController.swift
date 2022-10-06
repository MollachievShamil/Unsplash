//
//  FavouriteImagesViewController.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

class FavouriteImagesViewController: UIViewController {
    
    var presenter: FavoriteImagesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension FavouriteImagesViewController: FavoriteImagesViewProtocol {
    
}
