//
//  SingleRepoWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nwachukwu Ejiofor on 13/09/2024.
//

import SwiftUI
import WidgetKit

struct SingleRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.primaryRepo)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleRepoEntry) -> Void) {
        let entry = SingleRepoEntry(date: .now, repo: MockData.primaryRepo)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleRepoEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            let repoUrl = RepoURL.publish
            
            do {
                // Get Repo
                var repo = try await NetworkManager.shared.getRepo(atUrl: repoUrl)
                let avatarImageData = await NetworkManager.shared.downloadRepoImage(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                if context.family == .systemLarge {
                    // Get contributors
                    let contributors = try await NetworkManager.shared.getContributors(atUrl: repoUrl + "/contributors")
                    
                    // Filter out the top 4
                    var top4 = Array(contributors.prefix(4))
                    
                    // Download top 4 avatars
                    for i in top4.indices {
                        let avatarImageData = await NetworkManager.shared.downloadRepoImage(from: top4[i].avatarUrl)
                        top4[i].avatarData = avatarImageData ?? Data()
                    }
                    repo.contributors = top4
                }
                
                // Create entry and timeline
                let entry = SingleRepoEntry(date: .now, repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct SingleRepoEntry: TimelineEntry {
    var date: Date
    var repo: Repository
}

struct SingleRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: SingleRepoEntry

    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack {
                RepoMediumView(repo: entry.repo)
                Spacer().frame(height: 25)
                ContributorMediumView(repo: entry.repo)
            }
        case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}

struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SingleRepoProvider()) { entry in
            if #available(iOS 17.0, *) {
                SingleRepoEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SingleRepoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Single Repo")
        .description("Keep track of your favourite repo's changes and top contributors.")
        .supportedFamilies([.systemMedium, .systemLarge])
//        .contentMarginsDisabled()
    }
}

#Preview(as: .systemLarge) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.primaryRepo)
    SingleRepoEntry(date: .now, repo: MockData.secondaryRepo)
}
