//
//  NewsService.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 15/11/24.
//

import Foundation
import Combine

protocol NewsServiceProtocol {
    func fetchNews(forCategory category: NewsCategory, page: Int) -> AnyPublisher<[NewsArticle], Error>
}

final class NewsService: NewsServiceProtocol {
    // MARK: - Constants
    private static let baseURL = "https://newsapi.org/v2/top-headlines"
    private static let apiKey = "YOUR_API_KEY_HERE"

    // MARK: - Properties
    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Initializer
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Public Methods
    func fetchNews(forCategory category: NewsCategory, page: Int) -> AnyPublisher<[NewsArticle], Error> {
        guard let url = buildURL(forCategory: category, page: page) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsAPIResponse.self, decoder: decoder)
            .map(\.articles)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Private Methods
    private func buildURL(forCategory category: NewsCategory, page: Int) -> URL? {
        var components = URLComponents(string: Self.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: Self.apiKey),
            URLQueryItem(name: "category", value: category.rawValue)
        ]
        return components?.url
    }
}
