//
//  BookmarksViewModelTests.swift
//  PulsePointTests
//
//  Created by Yusuf Ansar  on 18/11/24.
//

import XCTest
@testable import PulsePoint

@MainActor
final class BookmarksViewModelTests: XCTestCase {
    var viewModel: BookmarksViewModel!

    override func setUp() {
        super.setUp()
        viewModel = BookmarksViewModel()

    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
}
