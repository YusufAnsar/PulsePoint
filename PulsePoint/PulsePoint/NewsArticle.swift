//
//  NewsArticle.swift
//  PulsePoint
//
//  Created by Yusuf Ansar  on 15/11/24.
//

import Foundation

struct NewsArticle: Identifiable, Codable, Equatable {
    // Client generated
    let id: UUID = UUID()

    let title: String
    let description: String?
    let source: Source
    let url: URL
    let urlToImage: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case source
        case url
        case urlToImage
    }

    var descriptionText: String {
        description ?? ""
    }

    var imageURL: URL? {
        guard let urlToImage = urlToImage else { return nil }
        return URL(string: urlToImage)
    }

    // MARK: - Nested Types
    struct Source: Codable, Equatable {
        let name: String
    }
}

// MARK: - Mock Data
extension NewsArticle {
    static let mock: NewsArticle = .init(
        title: "Mock Title",
        description: "Mock Description",
        source: .init(name: "Mock Source"),
        url: .init(string: "https://mock.com")!,
        urlToImage: "https://mock.com/image.jpg"
    )
}

// MARK: - API Response Model
struct NewsAPIResponse: Codable {
    let articles: [NewsArticle]
}
