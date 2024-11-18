//
//  NewsListView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 15/11/24.
//

import SwiftUI

struct NewsListView: View {
    @State var viewModel: NewsListViewModel
    @State private var selectedArticle: NewsArticle?

    var body: some View {
        NavigationView {
            content
                .navigationTitle(viewModel.selectedCategory.description)
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: categoryMenu)
                .onAppear {
                    if viewModel.articles.isEmpty {
                        viewModel.loadArticles()
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.articles.isEmpty {
            emptyStateView
        } else {
            articleListView
        }
    }

    private var emptyStateView: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage) {
                    viewModel.loadArticles()
                }
            } else {
                EmptyStateView(text: "No articles available", imageName: "tray")
            }
        }
    }

    private var articleListView: some View {
        List {
            ForEach(viewModel.articles) { article in
                NewsRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
                    .onAppear {
                        if article.id == viewModel.articles.last?.id {
                            viewModel.fetchArticles()
                        }
                    }
            }
            .listRowInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            .listRowSeparator(.hidden)

            if viewModel.isLoading {
                loadingIndicator
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.loadArticles()
        }
        .sheet(item: $selectedArticle) { article in
            SafariView(url: article.url)
        }
    }

    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

    private var categoryMenu: some View {
        Menu {
            ForEach(NewsCategory.allCases) { category in
                Button {
                    viewModel.selectedCategory = category
                    viewModel.loadArticles()
                } label: {
                    Text(category.description)
                }
            }
        } label: {
            Image(systemName: "menubar.rectangle")
                .imageScale(.large)
        }
    }
}

#Preview {
    let viewModel = NewsListViewModel(newsService: NewsService())
    NewsListView(viewModel: viewModel)
        .environment(BookmarksViewModel.shared)
}
