//
//  NewsListViewModel.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 15/11/24.
//

import Foundation
import Combine

@MainActor
@Observable
class NewsListViewModel {

    // MARK: - Properties
    var articles: [NewsArticle] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var selectedCategory: NewsCategory = .general

    private var currentPage: Int = 1
    private var hasMoreArticles: Bool = true
    private let newsService: NewsServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }

    // MARK: - Public Methods

    /// Fetches articles for the selected category.
    func fetchArticles() {
        guard !isLoading, hasMoreArticles else { return }

        isLoading = true
        errorMessage = nil

        newsService.fetchNews(forCategory: selectedCategory, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: handleNewArticles(_:)
            )
            .store(in: &cancellables)
    }

    /// Resets and reloads articles.
    func loadArticles() {
        resetPagination()
        fetchArticles()
    }

    // MARK: - Private Methods

    /// Handles completion of the fetch request.
    /// - Parameter completion: The completion result of the Combine publisher.
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        isLoading = false
        if case .failure(let error) = completion {
            errorMessage = "Failed to fetch articles: \(error.localizedDescription)"
        }
    }

    /// Processes newly fetched articles.
    /// - Parameter newArticles: The articles fetched from the service.
    private func handleNewArticles(_ newArticles: [NewsArticle]) {
        if newArticles.isEmpty {
            hasMoreArticles = false
        } else {
            articles = articles + newArticles
            currentPage += 1
        }
        isLoading = false
    }

    /// Resets pagination and clears articles.
    private func resetPagination() {
        articles = []
        currentPage = 1
        hasMoreArticles = true
    }
}
