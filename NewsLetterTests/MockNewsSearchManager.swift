//
//  MockNewsSearchManager.swift
//  NewsLetterTests
//
//  Created by 김민지 on 2022/06/20.
//

import XCTest
@testable import NewsLetter

final class MockNewsSearchManager: NewsSearchManagerProtocol {
  var error: Error?
  var isCalledRequest = false

  func request(
    from keyword: String,
    start: Int,
    display: Int,
    completionHandler: @escaping ([News]) -> Void
  ) {
    isCalledRequest = true

    if error == nil {
      completionHandler([])
    }
  }
}
