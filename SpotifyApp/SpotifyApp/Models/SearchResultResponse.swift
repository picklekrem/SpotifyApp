//
//  SearchResultResponse.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 16.09.2021.
//

import Foundation

struct SearchResultResponse : Codable {
    let albums : SearchAlbumResponse
    let artists : SearchArtistsResponse
    let playlists : SearchPlaylistResponse
    let tracks : SearchTracksResponse
}
struct SearchAlbumResponse : Codable {
    let items : [Album]
}
struct SearchArtistsResponse : Codable {
    let items: [Artist]
}
struct SearchPlaylistResponse : Codable {
    let items : [Playlist]
}
struct SearchTracksResponse : Codable {
    let items: [AudioTrack]
}
