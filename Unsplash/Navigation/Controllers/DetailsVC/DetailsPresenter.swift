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
        let item = model.urls?.small
        if let item = item {
            return item
        } else {
            return " .......... "
        }
    }
    
    func getData() -> Data {
        let item = model.picture
        if let item = item {
            return item
        }
        return Data()
    }
    
    func getNameLabel() -> String {
        let item = model.user?.name
        if let item = item {
            return item
        } else {
            return " .......... "
        }
    }
    
    func getDateOfCreationLabel() -> String {
        let item = model.createdAt
        if let item = item {
            let formattedDate = setDateFormat(date: item)
            return formattedDate
        } else {
            return " .......... "
        }
    }
    
    func getLocationLabel() -> String {
        let item = model.user?.location
        if let item = item {
            return item
        } else {
            return " .......... "
        }
    }
    
    func getDownloadsLabel() -> String {
        let item = model.downloads
        
        if let item = item {
            return "Downloaded \(String(item)) times"
        } else {
            return ""
        }
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
