//
//  Storage.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import RealmSwift

protocol StorageProtocol {
    func saveDelete(picture: StorageModel)
    var picturesInRealm: Results<StorageModel> { get }
    func imageExistInRealm(model: StorageModel) -> Bool
    func delete(model: StorageModel)
}

class Storage: StorageProtocol {
    
    private var realm = try! Realm()
    
    var picturesInRealm: Results<StorageModel> {
        realm.objects(StorageModel.self)
    }
    
    func imageExistInRealm(model: StorageModel) -> Bool {
        picturesInRealm.contains(where: { $0.pictureData == model.pictureData })
    }
    
    func saveDelete(picture: StorageModel) {
        imageExistInRealm(model: picture) ? delete(model: picture) : save(picture: picture)
    }
    
    private func save(picture: StorageModel) {
        try? realm.write {
            realm.add(picture)
        }
    }
    
    func delete(model: StorageModel) {
        try? realm.write {
            realm.delete(realm.objects(StorageModel.self).filter("pictureData=%@",model.pictureData))
        }
    }
}
