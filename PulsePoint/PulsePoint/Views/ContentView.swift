//
//  ContentView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 18/11/24.
//

import SwiftUI

struct ContentView: View {

    private let newsService = NewsService()

    var body: some View {
        TabView {
            NewsListView(viewModel: NewsListViewModel(newsService: newsService))
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

            BookmarksView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
