//
//  BookmarksViewModel.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 18/11/24.
//

import SwiftUI

@MainActor
@Observable
class BookmarksViewModel {

    // MARK: - Properties
    private(set) var bookmarks: [NewsArticle] = []
    private let bookmarksStore: PlistDataStore<[NewsArticle]>

    static let shared = BookmarksViewModel()

    // MARK: - Initializer
    init(bookmarksStore: PlistDataStore<[NewsArticle]> = PlistDataStore<[NewsArticle]>(filename: "bookmarks")) {
        self.bookmarksStore = bookmarksStore
        Task {
            await loadBookmarks()
        }
    }

    // MARK: - Bookmark Management
    private func loadBookmarks() async {
        bookmarks = await bookmarksStore.load() ?? []
    }

    func isBookmarked(article: NewsArticle) -> Bool {
        bookmarks.contains { $0.id == article.id }
    }

    func addBookmark(article: NewsArticle) {
        guard !isBookmarked(article: article) else { return }

        bookmarks.insert(article, at: 0)
        updateBookmarks()
    }

    func removeBookmark(article: NewsArticle) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }

        bookmarks.remove(at: index)
        updateBookmarks()
    }

    // MARK: - Helpers
    private func updateBookmarks() {
        Task {
            await bookmarksStore.save(bookmarks)
        }
    }
}
