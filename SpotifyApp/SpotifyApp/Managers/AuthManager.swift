//
//  AuthManager.swift
//  SpotifyApp
//
//  Created by Ekrem Özkaraca on 19.08.2021.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "62d90ad2902242458f86e7dd337b8c2b"
        static let clientSecret = "d810de7e13c74a0ab75ea9da2b5c9225"
    }
    
    private init () {}
    
    public var signInURL : URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://www.linkedin.com/in/ekremozkaraca/"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
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
    
    public func exchangeCodeForToken(code:String, completion: @escaping ((Bool) -> Void)) {
        // Get token
    }
    public func refreshAccessToken() {
        
    }
    private func cacheToken(){
        
    }
}
