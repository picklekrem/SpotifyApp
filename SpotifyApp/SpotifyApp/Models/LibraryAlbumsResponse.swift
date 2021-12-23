//
//  LibraryAlbumsResponse.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 23.12.2021.
//

import Foundation

struct LibraryAlbumsResponse : Codable {
    let items : [SavedAlbums]
}
struct SavedAlbums : Codable {
    let added_at : String
    let album : Album
}
