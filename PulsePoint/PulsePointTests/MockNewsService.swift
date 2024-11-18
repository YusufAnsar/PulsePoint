//
//  MockNewsService.swift
//  PulsePoint
//
//  Created by Yusuf Ansar  on 18/11/24.
//

import Foundation
import Combine
@testable import PulsePoint

final class MockNewsService: NewsServiceProtocol {
    
    var mockResult: Result<[NewsArticle], Error>?

    func fetchNews(forCategory category: NewsCategory, page: Int) -> AnyPublisher<[NewsArticle], Error> {
        guard let result = mockResult else {
            return Fail(error: NSError(domain: "TestError", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }

        return Future { promise in
            promise(result)
        }
        .eraseToAnyPublisher()
    }
}
