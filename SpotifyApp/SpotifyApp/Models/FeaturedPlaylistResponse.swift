//
//  FeaturedPlaylistResponse.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 24.08.2021.
//

import Foundation

struct FeaturedPlaylistResponse : Codable {
    let playlists : PlaylistResponse
}
struct CategoryPlaylistResponse : Codable {
    let playlists : PlaylistResponse
}
struct PlaylistResponse : Codable {
    let items : [Playlist]
}

struct User : Codable {
    let display_name : String
    let external_urls : [String:String]
    let id : String
}
