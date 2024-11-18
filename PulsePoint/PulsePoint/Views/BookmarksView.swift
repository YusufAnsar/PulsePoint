//
//  BookmarksView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar  on 18/11/24.
//

import SwiftUI

struct BookmarksView: View {
    @Environment(BookmarksViewModel.self) private var viewModel
    @State private var selectedArticle: NewsArticle?
    @State var searchText: String = ""

    var body: some View {
        let articles = self.articles

        NavigationView {
            List {
                ForEach(articles) { article in
                    NewsRowView(article: article)
                        .onTapGesture {
                            selectedArticle = article
                        }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .sheet(item: $selectedArticle) { article in
                SafariView(url: article.url)
            }
            .overlay(overlayView())
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.large)
        }
        .searchable(text: $searchText)
    }


    private var articles: [NewsArticle] {
        if searchText.isEmpty {
            return viewModel.bookmarks
        }
        return viewModel.bookmarks
            .filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }


    @ViewBuilder
    func overlayView() -> some View {
        if articles.isEmpty {
            EmptyStateView(text: "No bookmarks", imageName: "bookmark")
        }
    }
}

#Preview {
    BookmarksView()
        .environment(BookmarksViewModel.shared)
}
