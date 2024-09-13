//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Nwachukwu Ejiofor on 12/09/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RepoEntry {
        RepoEntry(date: Date(), repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo)
    }

    func getSnapshot(in context: Context, completion: @escaping (RepoEntry) -> ()) {
        let entry = RepoEntry(date: Date(), repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            do {
                // Get primary repo
                var repo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.swiftNews)
                let avatarImageData = await NetworkManager.shared.downloadRepoImage(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                // Get secondary repo if in large widget
                var secondRepo: Repository?
                if context.family == .systemLarge {
                    secondRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.publish)
                    let avatarImageData = await NetworkManager.shared.downloadRepoImage(from: secondRepo!.owner.avatarUrl)
                    secondRepo!.avatarData = avatarImageData ?? Data()
                }
                
                // Create entry and timeline
                let entry = RepoEntry(date: .now, repo: repo, secondRepo: secondRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct RepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let secondRepo: Repository?
}

struct RepoWatcherWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: RepoEntry

    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack(spacing: 36) {
                RepoMediumView(repo: entry.repo)
                if let secondRepo = entry.secondRepo {
                    RepoMediumView(repo: secondRepo)
                }
            }
        case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}



struct RepoWatcherWidget: Widget {
    let kind: String = "RepoWatcherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                RepoWatcherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RepoWatcherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Repo Updates")
        .description("Keep up-to-date with key stats of Github repos you're interested in")
//        .contentMarginsDisabled()
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

#Preview(as: .systemLarge ) {
    RepoWatcherWidget()
} timeline: {
    RepoEntry(date: .now, repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo)
}
