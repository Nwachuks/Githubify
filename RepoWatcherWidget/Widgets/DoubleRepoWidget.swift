//
//  DoubleRepoWidget.swift
//  DoubleRepoWidget
//
//  Created by Nwachukwu Ejiofor on 12/09/2024.
//

import WidgetKit
import SwiftUI

struct DoubleRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> DoubleRepoEntry {
        DoubleRepoEntry(date: Date(), topRepo: MockData.primaryRepo, bottomRepo: MockData.secondaryRepo)
    }

    func getSnapshot(in context: Context, completion: @escaping (DoubleRepoEntry) -> ()) {
        let entry = DoubleRepoEntry(date: Date(), topRepo: MockData.primaryRepo, bottomRepo: MockData.secondaryRepo)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            do {
                // Get top repo
                var topRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.swiftNews)
                let topAvatarImageData = await NetworkManager.shared.downloadRepoImage(from: topRepo.owner.avatarUrl)
                topRepo.avatarData = topAvatarImageData ?? Data()
                
                // Get bottom repo
                var bottomRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.publish)
                let bottomAvatarImageData = await NetworkManager.shared.downloadRepoImage(from: bottomRepo.owner.avatarUrl)
                bottomRepo.avatarData = bottomAvatarImageData ?? Data()
                
                // Create entry and timeline
                let entry = DoubleRepoEntry(date: .now, topRepo: topRepo, bottomRepo: bottomRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct DoubleRepoEntry: TimelineEntry {
    let date: Date
    let topRepo: Repository
    let bottomRepo: Repository
}

struct DoubleRepoEntryView : View {
    var entry: DoubleRepoEntry

    var body: some View {
        VStack(spacing: 36) {
            RepoMediumView(repo: entry.topRepo)
            RepoMediumView(repo: entry.bottomRepo)
        }
    }
}

struct DoubleRepoWidget: Widget {
    let kind: String = "DoubleRepoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DoubleRepoProvider()) { entry in
            if #available(iOS 17.0, *) {
                DoubleRepoEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DoubleRepoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Repo Updates")
        .description("Keep up-to-date with key stats of 2 Github repos you're interested in")
        .supportedFamilies([.systemLarge])
//        .contentMarginsDisabled()
    }
}

#Preview(as: .systemLarge) {
    DoubleRepoWidget()
} timeline: {
    DoubleRepoEntry(date: .now, topRepo: MockData.primaryRepo, bottomRepo: MockData.secondaryRepo)
}
