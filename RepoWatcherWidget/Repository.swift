//
//  Repository.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 12/09/2024.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    
    var daysSinceLastActivity: Int {
        return calculateDaysSinceLastActivity(from: pushedAt)
    }
    
    func calculateDaysSinceLastActivity(from dateString: String) -> Int {
        let formatter = ISO8601DateFormatter()
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        return daysSinceLastActivity
    }
    
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true, forks: 75,
                                        watchers: 123, openIssues: 55,
                                        pushedAt: "2024-03-09T18:19:30Z")
}

struct Owner: Decodable {
    let avatarUrl: String
}
