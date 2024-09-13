//
//  RepoWatcherWidgetBundle.swift
//  RepoWatcherWidget
//
//  Created by Nwachukwu Ejiofor on 12/09/2024.
//

import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgetBundle: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
