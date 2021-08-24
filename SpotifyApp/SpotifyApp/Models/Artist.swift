//
//  Artist.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 19.08.2021.
//

import Foundation

struct Artist : Codable {
    let id :String
    let name :String
    let type :String
    let external_urls : [String: String]
}
