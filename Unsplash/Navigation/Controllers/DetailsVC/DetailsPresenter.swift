//
//  DetailsPresenter.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setUpPhoto(image: UIImage?)
}

protocol DetailsPresenterProtocol: AnyObject {
    var model: PhotoModel {get set}
    func getNameLabel() -> String
    func getDateOfCreationLabel() -> String
    func getLocationLabel() -> String
    func getDownloadsLabel() -> String
    func downloadPhoto()
    func getData() -> Data
    func saveDeleteFromRealm(model: StorageModel)
    func getURL() -> String
    func imageExistInRealm(model: StorageModel) -> Bool
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    let router: RouterProtocol
    var storage: StorageProtocol
    var model: PhotoModel
    
    init(view: DetailsViewProtocol, router: RouterProtocol, storage: StorageProtocol, model: PhotoModel) {
        self.view = view
        self.router = router
        self.storage = storage
        self.model = model
        downloadPhoto()
    }
    
    // MARK: - Work With Realm
    func imageExistInRealm(model: StorageModel) -> Bool {
        return storage.imageExistInRealm(model: model)
    }
    
    func saveDeleteFromRealm(model: StorageModel) {
        storage.saveDelete(picture: model)
    }
    
    // MARK: - set lables
    func getURL() -> String {
        guard let item = model.urls?.small else { return "" }
        return item
    }
    
    func getData() -> Data {
        let item = model.picture
        if let item = item {
            return item
        }
        return Data()
    }
    
    func getNameLabel() -> String {
        guard let item = model.user?.name else { return "" }
        return item
    }
    
    func getDateOfCreationLabel() -> String {
        guard let item = model.createdAt else { return "" }
        let formattedDate = setDateFormat(date: item)
        return formattedDate
    }
    
    func getLocationLabel() -> String {
        guard let item = model.user?.location else { return "" }
        return item
    }
    
    func getDownloadsLabel() -> String {
        guard let item = model.downloads else { return ""}
        return "Downloaded \(String(item)) times"
    }
    
    // MARK: - Transform data from model in Images
    
    func downloadPhoto() {
        guard let data = model.picture else { return }
        view?.setUpPhoto(image: UIImage(data: data))
    }
}

// MARK: - Date formatter
extension DetailsPresenter {
    private func setDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
}
