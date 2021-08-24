//
//  SettingsModel.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 23.08.2021.
//

import Foundation

struct Section {
    let title : String
    let option : [Option]
}

struct Option {
    let title :String
    let handler : () -> Void
}
