//
//  NewsLetterUITests.swift
//  NewsLetterUITests
//
//  Created by 김민지 on 2022/06/06.
//

import XCTest

final class NewsLetterUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()

    continueAfterFailure = false  // 하나라도 실패하면 종료

    app = XCUIApplication() // 테스트를 위한 UIApplication
    app.launch()            // 테스트 앱 실행
  }

  override func tearDown() {
    super.tearDown()

    app = nil
  }

  func test_navigationBar의_title이_News로_되어있다() {
    let existsNavigationBar = app.navigationBars["News"].exists
    XCTAssertTrue(existsNavigationBar)
  }

  func test_searchBar가_존재한다() {
    let existsSearchBar = app.navigationBars["News"].searchFields["Search"].exists
    XCTAssertTrue(existsSearchBar)
  }

  func test_searchBar에_cancel버튼이_존재한다() {
    let navigationBar = app.navigationBars["News"]
    navigationBar.searchFields["Search"].tap()

    let existsSearchBarCancelButton = navigationBar.buttons["Cancel"].exists
    XCTAssertTrue(existsSearchBarCancelButton)
  }
}
