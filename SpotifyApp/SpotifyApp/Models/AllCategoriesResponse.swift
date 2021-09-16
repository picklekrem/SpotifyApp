//
//  AllCategoriesResponse.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 15.09.2021.
//

import Foundation

struct AllCategoriesResponse : Codable {
    let categories : Categories
}
struct Categories : Codable {
    let items : [Category]
}
struct Category : Codable {
    let id : String
    let name : String
    let icons : [APIImage]
}
