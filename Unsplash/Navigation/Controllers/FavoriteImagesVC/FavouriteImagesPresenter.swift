//
//  FavouriteImagesPresenter.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol FavoriteImagesViewProtocol: AnyObject {
    func sucsess()
}

protocol FavoriteImagesPresenterProtocol: AnyObject {
    func goToDetailsModule(ind: Int)
    func fetchName(index: Int) -> String
    func getNumresOfCells() -> Int
    func getImageForCell(ind: Int) -> UIImage
    var images: [Data] {get set}
    func deleteWithSwipe(ind: Int)
}

class FavoriteImagesPresenter: FavoriteImagesPresenterProtocol {
    
    weak var view: FavoriteImagesViewProtocol?
    private let router: RouterProtocol
    private var storage: StorageProtocol
    var images = [Data]()
    
    init(view: FavoriteImagesViewProtocol, router: RouterProtocol, storage: StorageProtocol) {
        self.view = view
        self.router = router
        self.storage = storage
    }
    
    // MARK: - Set labels
    func getNumresOfCells() -> Int {
        return storage.picturesInRealm.count
    }
    
    func fetchName(index: Int) -> String {
        return storage.picturesInRealm[index].name
    }
    
    // MARK: - Transform Network Model to Realm Model
    
    func createModel(ind: Int) -> PhotoModel {
        let realm = storage.picturesInRealm[ind]
        let url = realm.URL
        let created = realm.createdAt
        let downloads = Int(realm.downloads)
        let user = realm.name
        let picture = Data(realm.pictureData)
        let location = realm.location
        
        let model = PhotoModel(urls: Urls(small: url),
                               createdAt: created,
                               downloads: downloads,
                               user: User(name: user, location: location),
                               picture: picture)
        return model
    }
    
    // MARK: - Transform data from model in Images
    func getImageForCell(ind: Int) -> UIImage {
        let data = storage.picturesInRealm[ind].pictureData
        return UIImage(data: data) ?? UIImage()
    }
    
    // MARK: - Deleting
    func deleteWithSwipe(ind: Int) {
        let model = (storage.picturesInRealm[ind])
        storage.delete(model: model)
        view?.sucsess()
    }
    
    // MARK: - Navigation
    func goToDetailsModule(ind: Int) {
        let model = createModel(ind: ind)
        router.showDetailsViewController(model: model)
    }
}
