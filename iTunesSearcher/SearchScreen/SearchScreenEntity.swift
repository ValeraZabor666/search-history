//
//  SearchScreenEntity.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import RealmSwift

struct Response: Codable {
    let results: [Album]
}

struct Album: Codable {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
}

class Detail {
    static let sharedData = Detail()
    
    var collectionId = 0
    var artistName = ""
    var albumName = ""
    var image: UIImage?
}

class History: Object {
    @objc dynamic var searching: String?
}
