//
//  NewsListViewModelTests.swift
//  PulsePointTests
//
//  Created by Yusuf Ansar on 18/11/24.
//

import XCTest
import Combine
@testable import PulsePoint

@MainActor
final class NewsListViewModelTests: XCTestCase {

    private var viewModel: NewsListViewModel!
    private var mockNewsService: MockNewsService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        viewModel = NewsListViewModel(newsService: mockNewsService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockNewsService = nil
        cancellables = nil
        super.tearDown()
    }
}


