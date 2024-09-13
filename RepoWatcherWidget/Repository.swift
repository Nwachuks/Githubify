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
    let description: String
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: Date
    
    var daysSinceLastActivity: Int {
        return calculateDaysSinceLastActivity(from: pushedAt)
    }
    
    func calculateDaysSinceLastActivity(from date: Date) -> Int {
//        let formatter = ISO8601DateFormatter()
//        let lastActivityDate = formatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: date, to: .now).day ?? 0
        return daysSinceLastActivity
    }
    
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        description: "What your repo does",
                                        hasIssues: true, forks: 75,
                                        watchers: 123, openIssues: 55,
                                        pushedAt: Date().addingTimeInterval(-10000000))
}

struct Owner: Decodable {
    let avatarUrl: String
}
