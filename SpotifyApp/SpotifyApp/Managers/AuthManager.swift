//
//  AuthManager.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 19.08.2021.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init () {}
    
    var isSignedIn : Bool {
        return false
    }
    private var accessToken : String? {
        return nil
    }
    
    private var refreshToken : String? {
        return nil
    }
    
    private var tokenExpireDate : Date? {
        return nil
    }
    
    private var shouldRefreshToken : Bool? {
        return false
    }
}
