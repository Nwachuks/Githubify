//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nwachukwu Ejiofor on 13/09/2024.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                .padding(.bottom, 2)
                
                Text(repo.description)
                    .padding(.bottom, 1)
                
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if !repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(repo.daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 60))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(repo.daysSinceLastActivity > 50 ? .pink : .green)
                
                Text("\(repo.daysSinceLastActivity == 1 ? "day" : "days") ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

fileprivate struct StatLabel: View {
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
        } icon: {
            Image(systemName: systemImageName)
                .foregroundStyle(.green)
        }
        .fontWeight(.medium)
    }
}

struct RepoMedium_Previews: PreviewProvider {
    static var previews: some View {
        RepoMediumView(repo: MockData.primaryRepo)
            .containerBackground(.fill.tertiary, for: .widget)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
