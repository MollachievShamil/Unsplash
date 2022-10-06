//
//  StorageModel.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import RealmSwift

class StorageModel: Object {
    @objc dynamic var name = String()
    @objc dynamic var pictureData = Data()
    @objc dynamic var downloads = Int()
    @objc dynamic var createdAt = String()
    @objc dynamic var URL = String()
    @objc dynamic var location = String()
}
