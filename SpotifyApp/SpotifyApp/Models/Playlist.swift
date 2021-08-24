//
//  Playlist.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 19.08.2021.
//

import Foundation

struct Playlist : Codable {
    let description : String
    let external_urls : [String:String]
    let id : String
    let images :[APIImage]
    let name : String
    let owner : User
}
