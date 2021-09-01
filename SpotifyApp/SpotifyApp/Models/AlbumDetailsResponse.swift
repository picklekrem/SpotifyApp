//
//  AlbumDetailsResponse.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 1.09.2021.
//

import Foundation

struct AlbumDetailsResponse : Codable {
    let album_type : String
    let artists : [Artist]
    let available_markets :[String]
    let external_urls : [String:String]
    let id : String
    let images :[APIImage]
    let label : String
    let name : String
    let tracks : TrackResponse
}
struct TrackResponse : Codable{
    let items : [AudioTrack]
}
