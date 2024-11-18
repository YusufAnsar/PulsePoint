//
//  NewsCategory.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 18/11/24.
//

import Foundation

/// Represents different categories of news articles.
enum NewsCategory: String, CaseIterable, Identifiable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health

    /// A user-friendly description of the news category.
    var description: String {
        switch self {
        case .general:
            return "Top Headlines"
        default:
            return rawValue.capitalized
        }
    }

    /// Unique identifier for the category.
    var id: Self { self }
}
