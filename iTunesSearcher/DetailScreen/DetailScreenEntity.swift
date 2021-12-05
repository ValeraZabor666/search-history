//
//  DetailScreenEntity.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation

struct DetailResponse: Codable {
    let results: [Track]
}

struct Track: Codable {
    let artistName: String
    let collectionName: String
    let trackName: String?
    let primaryGenreName: String
}
