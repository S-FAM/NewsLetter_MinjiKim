//
//  NewsLetterTests.swift
//  NewsLetterTests
//
//  Created by 김민지 on 2022/06/06.
//

import XCTest
@testable import NewsLetter

final class NewsLetterTests: XCTestCase {
  var sut: NewsListPresenter!

  var viewController: MockNewsListViewController!
  var newsSearchManager: MockNewsSearchManager!

  override func setUp() {
    super.setUp()

    viewController = MockNewsListViewController()
    newsSearchManager = MockNewsSearchManager()

    sut = NewsListPresenter(
      viewController: viewController,
      newsSearchManager: newsSearchManager
    )
  }

  override func tearDown() {
    sut = nil
    newsSearchManager = nil
    viewController = nil

    super.tearDown()
  }

  func test_viewDidLoad가_요청될때() {
    sut.viewDidLoad()

    XCTAssertTrue(viewController.isCalledSetupNavigationBar)
    XCTAssertTrue(viewController.isCalledSetupView)
  }

  func test_didCalledRefresh가_요청될때_request에_실패하면() {
    newsSearchManager.error = NSError() as Error
    sut.didCalledRefresh()

    XCTAssertFalse(viewController.isCalledReloadTableView)
    XCTAssertFalse(viewController.isCalledEndRefreshing)
  }

  func test_didCalledRefresh가_요청될때_request에_성공하면() {
    newsSearchManager.error = nil
    sut.didCalledRefresh()

    XCTAssertTrue(viewController.isCalledReloadTableView)
    XCTAssertTrue(viewController.isCalledEndRefreshing)
  }
}
