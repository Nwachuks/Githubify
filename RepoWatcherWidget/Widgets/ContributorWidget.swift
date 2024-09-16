//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nwachukwu Ejiofor on 13/09/2024.
//

import SwiftUI
import WidgetKit

struct ContributorProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry(date: .now, repo: MockData.primaryRepo)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> Void) {
        let entry = ContributorEntry(date: .now, repo: MockData.primaryRepo)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            let repoUrl = RepoURL.publish
            
            do {
                // Get Repo
                var repo = try await NetworkManager.shared.getRepo(atUrl: repoUrl)
                let avatarImageData = await NetworkManager.shared.downloadRepoImage(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
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
                
                // Create entry and timeline
                let entry = ContributorEntry(date: .now, repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct ContributorEntry: TimelineEntry {
    var date: Date
    var repo: Repository
}

struct ContributorEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: ContributorEntry

    var body: some View {
        switch family {
        case .systemMedium:
            ContributorMediumView(repo: entry.repo)
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

struct ContributorWidget: Widget {
    let kind: String = "ContributorWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            if #available(iOS 17.0, *) {
                ContributorEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ContributorEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Repo Contributors")
        .description("Keep track of a repo's top contributors.")
        .supportedFamilies([.systemLarge])
//        .contentMarginsDisabled()
    }
}

#Preview(as: .systemLarge) {
    ContributorWidget()
} timeline: {
    ContributorEntry(date: .now, repo: MockData.primaryRepo)
    ContributorEntry(date: .now, repo: MockData.secondaryRepo)
}

//struct ContributorWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        ContributorEntryView(entry: ContributorEntry(date: Date(), repo: MockData.primaryRepo))
//            .containerBackground(.fill.tertiary, for: .widget)
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//    }
//}
