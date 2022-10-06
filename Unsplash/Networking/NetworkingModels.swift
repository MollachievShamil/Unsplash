//
//  NetworkingModels.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import Foundation

struct SearchModel: Codable {
    let results: [PhotoModel]
}

struct PhotoModel: Codable {
    let urls: Urls?
    let createdAt: String?
    let downloads: Int?
    let user: User?
    var picture: Data?
}

struct Urls: Codable {
    let small: String?
}

struct User: Codable {
    let name: String?
    let location: String?
}
