//
//  Contributor.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 13/09/2024.
//

import Foundation

struct Contributor {
    let login: String
    let avatarUrl: String
    let contributions: Int
    
    var avatarData: Data
}

extension Contributor {
    struct CodingData: Decodable {
        let login: String
        let avatarUrl: String
        let contributions: Int
        
        var contributor: Contributor {
            Contributor(login: login,
                        avatarUrl: avatarUrl,
                        contributions: contributions,
                        avatarData: Data()
            )
        }
    }
}
