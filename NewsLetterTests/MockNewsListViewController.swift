//
//  MockNewsListViewController.swift
//  NewsLetterTests
//
//  Created by 김민지 on 2022/06/20.
//

import XCTest
@testable import NewsLetter

final class MockNewsListViewController: NewsListProtocol {
  var isCalledSetupNavigationBar = false
  var isCalledSetupView = false
  var isCalledReloadTableView = false
  var isCalledOpenSFSafariView = false
  var isCalledEndRefreshing = false

  func setupNavigationBar() {
    isCalledSetupNavigationBar = true
  }

  func setupView() {
    isCalledSetupView = true
  }

  func reloadTableView() {
    isCalledReloadTableView = true
  }

  func openSFSafariView(_ url: String) {
    isCalledOpenSFSafariView = true
  }

  func endRefreshing() {
    isCalledEndRefreshing = true
  }
}
