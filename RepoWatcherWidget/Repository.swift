//
//  Repository.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 12/09/2024.
//

import Foundation

struct Repository {
    let name: String
    let owner: Owner
    let description: String
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: Date
    
    var avatarData: Data
    var contributors: [Contributor]
    
    var daysSinceLastActivity: Int {
        Calendar.current.dateComponents([.day], from: pushedAt, to: .now).day ?? 0
    }
}

extension Repository {
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let description: String
        let hasIssues: Bool
        let forks: Int
        let watchers: Int
        let openIssues: Int
        let pushedAt: Date
        
        var repo: Repository {
            Repository(
                name: name,
                owner: owner,
                description: description,
                hasIssues: hasIssues, 
                forks: forks,
                watchers: watchers,
                openIssues: openIssues,
                pushedAt: pushedAt,
                avatarData: Data(),
                contributors: []
            )
        }
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}
