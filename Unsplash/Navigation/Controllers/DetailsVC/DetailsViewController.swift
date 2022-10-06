//
//  DetailsViewController.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var presenter: DetailsPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}

extension DetailsViewController: DetailsViewProtocol {
    
}
