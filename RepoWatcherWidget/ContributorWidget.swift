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
        let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
        let entry = ContributorEntry(date: .now, repo: MockData.primaryRepo)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct ContributorEntry: TimelineEntry {
    var date: Date
    var repo: Repository
}

struct ContributorEntryView : View {
    var entry: ContributorEntry

    var body: some View {
        VStack {
            RepoMediumView(repo: entry.repo)
            Spacer()
            ContributorMediumView()
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
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

struct ContributorWidget_Previews: PreviewProvider {
    static var previews: some View {
        ContributorEntryView(entry: ContributorEntry(date: Date(), repo: MockData.primaryRepo))
            .containerBackground(.fill.tertiary, for: .widget)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
