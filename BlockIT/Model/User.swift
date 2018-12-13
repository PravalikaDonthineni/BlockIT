//
//  User.swift
//  BlockIT
//
//  Created by Gaurav Chintakindi on 12/13/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String?
    let password: String?
    var urls: [String]?
    
    init(userName: String, password: String, urls: [String]) {
        self.userName = userName
        self.password = password
        self.urls = urls
    }
}


struct UserProfileCache {
    
    // Save the user object to cache
    static func save(_ user: User) {
        if let username = user.userName, let password = user.password {
            let cacheKey = username + password
            UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: cacheKey)
        }
    }
    
    // retrieve the user object from cache
    static func get(cacheKey: String) -> User? {
        var user: User?
        if let data = UserDefaults.standard.value(forKey: cacheKey) as? Data {
            user = try? PropertyListDecoder().decode(User.self, from: data)
            return user
        }
        return nil
    }
}
