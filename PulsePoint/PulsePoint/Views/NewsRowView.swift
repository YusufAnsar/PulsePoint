//
//  NewsRowView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar  on 16/11/24.
//

import SwiftUI

struct NewsRowView: View {
    let article: NewsArticle
    @Environment(BookmarksViewModel.self) private var bookmarksViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ArticleImageView(imageURL: article.imageURL)

            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)

                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)

                HStack {
                    Text(article.source.name)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)

                    Spacer()

                    BookmarkButton(article: article, viewModel: bookmarksViewModel)
                }
            }
            .padding(.bottom)
        }
    }
}

private struct ArticleImageView: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                PlaceholderView(icon: "photo", isLoading: true)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                PlaceholderView(icon: "photo", isLoading: false)
            @unknown default:
                fatalError()
            }
        }
        .frame(minHeight: 200, maxHeight: 240)
        .background(Color.gray)
        .clipped()
    }
}

private struct PlaceholderView: View {
    let icon: String
    let isLoading: Bool

    var body: some View {
        HStack {
            Spacer()
            if isLoading {
                ProgressView()
            } else {
                Image(systemName: icon)
                    .imageScale(.large)
            }
            Spacer()
        }
    }
}

private struct BookmarkButton: View {
    let article: NewsArticle
    @State var viewModel: BookmarksViewModel

    var body: some View {
        Button {
            toggleBookmark()
        } label: {
            Image(systemName: viewModel.isBookmarked(article: article) ? "bookmark.fill" : "bookmark")
        }
        .buttonStyle(.bordered)
    }

    private func toggleBookmark() {
        if viewModel.isBookmarked(article: article) {
            viewModel.removeBookmark(article: article)
        } else {
            viewModel.addBookmark(article: article)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let article = NewsArticle(
        title: "Sample News",
        description: "News description",
        source: NewsArticle.Source(name: "Sample Source"),
        url: URL(string: "https://www.google.com")!,
        urlToImage: nil
    )
    NewsRowView(article: article)
        .environment(BookmarksViewModel.shared)
}
