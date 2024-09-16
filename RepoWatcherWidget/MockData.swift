//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nwachukwu Ejiofor on 13/09/2024.
//

import Foundation

struct MockData {
    static let primaryRepo = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        description: "What your repo does",
                                        hasIssues: true, forks: 75,
                                        watchers: 123, openIssues: 55,
                                        pushedAt: Date().addingTimeInterval(-10000000),
                                        avatarData: Data(),
                                        contributors: [
                                            Contributor(login: "Sean Allen", avatarUrl: "", contributions: 42, avatarData: Data()),
                                            Contributor(login: "Michael Jordan", avatarUrl: "", contributions: 23, avatarData: Data()),
                                            Contributor(login: "Allen Iverson", avatarUrl: "", contributions: 21, avatarData: Data()),
                                            Contributor(login: "Kobe Bryant", avatarUrl: "", contributions: 15, avatarData: Data())
                                        ]
    )
    
    static let secondaryRepo = Repository(name: "Second Repo",
                                          owner: Owner(avatarUrl: ""),
                                          description: "What your other repo does",
                                          hasIssues: false,
                                          forks: 43, watchers: 443,
                                          openIssues: 0,
                                          pushedAt: Date().addingTimeInterval(-500000),
                                          avatarData: Data(),
                                          contributors: [
                                            Contributor(login: "Lionel Messi", avatarUrl: "", contributions: 542, avatarData: Data()),
                                            Contributor(login: "Pele Dos Santos", avatarUrl: "", contributions: 423, avatarData: Data()),
                                            Contributor(login: "Diego Maradona", avatarUrl: "", contributions: 421, avatarData: Data()),
                                            Contributor(login: "Cristiano Ronaldo", avatarUrl: "", contributions: 615, avatarData: Data())
                                          ]
    )
}
