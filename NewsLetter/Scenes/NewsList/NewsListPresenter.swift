//
//  NewsListPresenter.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/07.
//

import UIKit
import SkeletonView

protocol NewsListProtocol: AnyObject {
  func setupNavigationBar()
  func setupView()

  func reloadTableView()
  func openSFSafariView(_ url: String)
  func endRefreshing()
}

final class NewsListPresenter: NSObject {
  private weak var viewController: NewsListProtocol?
  private let newsSearchManager: NewsSearchManagerProtocol

  private var newsList: [News] = []

  private var currentKeyword = "정치"
  private var currentPage: Int = 0
  private let display: Int = 20

  private let tags: [String] = [
    "정치", "경제", "금융", "증권", "부동산", "사회", "교육", "노동", "언론", "환경",
    "인권", "복지", "식품", "의료", "지역", "생활", "건강", "자동차", "도로", "교통",
    "문화", "여행", "음식", "패션", "뷰티", "공연", "전시", "책", "종교", "날씨",
    "IT", "모바일", "인터넷", "통신", "게임", "과학", "세계"
  ]

  init(
    viewController: NewsListProtocol,
    newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
  ) {
    self.viewController = viewController
    self.newsSearchManager = newsSearchManager
  }

  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupView()
  }

  func didCalledRefresh() {
    requestNewsList(isNeededToReset: true)
  }
}

extension NewsListPresenter: NewsListTableViewHeaderDelegate {
  func didSelectTag(_ selectedIndex: Int) {
    currentKeyword = tags[selectedIndex]
    requestNewsList(isNeededToReset: true)
  }
}

// MARK: - UISearchBar
extension NewsListPresenter: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }

    currentKeyword = searchText
    requestNewsList(isNeededToReset: true)
  }
}

// MARK: - UITableView
extension NewsListPresenter: SkeletonTableViewDataSource, UITableViewDelegate {
  // skeletonView
  func collectionSkeletonView(
    _ skeletonView: UITableView,
    cellIdentifierForRowAt indexPath: IndexPath
  ) -> ReusableCellIdentifier {
    NewsListTableViewCell.identifier
  }

  func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
    display
  }

  // tableView
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    newsList.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell =  tableView.dequeueReusableCell(
      withIdentifier: NewsListTableViewCell.identifier,
      for: indexPath
    ) as? NewsListTableViewCell else { return UITableViewCell() }

    let news = newsList[indexPath.row]
    cell.update(news: news)

    return cell
  }

  func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: NewsListTableViewHeader.identifier
    ) as? NewsListTableViewHeader else { return UIView() }

    header.setupView(tags: tags, delegate: self)

    return header
  }

  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    148.0
  }

  func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    50.0
  }

  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    let currentRow = indexPath.row
    guard (currentRow % display) == (display - 3) &&
            (currentRow / display) == (currentPage - 1) else { return }

    requestNewsList(isNeededToReset: false)
  }

  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let url = newsList[indexPath.row].link
    viewController?.openSFSafariView(url)
  }
}

// MARK: - Request NewsList
extension NewsListPresenter {
  func requestNewsList(isNeededToReset: Bool) {
    if isNeededToReset {
      newsList = []
      currentPage = 0
    }

    newsSearchManager.request(
      from: currentKeyword,
      start: (currentPage * display) + 1,
      display: display
    ) { [weak self] newValue in
      guard let self = self else { return }

      self.newsList += newValue
      self.currentPage += 1
      self.viewController?.reloadTableView()
      self.viewController?.endRefreshing()
    }
  }
}
