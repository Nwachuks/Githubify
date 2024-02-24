//
//  Follower.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 17/02/2024.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    // Hashable code sample
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
}
