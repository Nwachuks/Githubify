//
//  CompactRepoWidget.swift
//  CompactRepoWidget
//
//  Created by Nwachukwu Ejiofor on 12/09/2024.
//

import WidgetKit
import SwiftUI

struct CompactRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CompactRepoEntry {
        CompactRepoEntry(date: Date(), repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo)
    }

    func getSnapshot(in context: Context, completion: @escaping (CompactRepoEntry) -> ()) {
        let entry = CompactRepoEntry(date: Date(), repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo)
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
                let entry = CompactRepoEntry(date: .now, repo: repo, secondRepo: secondRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct CompactRepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let secondRepo: Repository?
}

struct CompactRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: CompactRepoEntry

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

struct CompactRepoWidget: Widget {
    let kind: String = "CompactRepoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompactRepoProvider()) { entry in
            if #available(iOS 17.0, *) {
                CompactRepoEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CompactRepoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Repo Updates")
        .description("Keep up-to-date with key stats of Github repos you're interested in")
        .supportedFamilies([.systemMedium, .systemLarge])
//        .contentMarginsDisabled()
    }
}

#Preview(as: .systemLarge) {
    CompactRepoWidget()
} timeline: {
    CompactRepoEntry(date: .now, repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo)
}

//struct CompactRepoWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        CompactRepoEntryView(entry: CompactRepoEntry(date: Date(), repo: MockData.primaryRepo, secondRepo: MockData.secondaryRepo))
//            .containerBackground(.fill.tertiary, for: .widget)
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//    }
//}
