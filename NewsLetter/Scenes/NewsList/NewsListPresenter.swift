//
//  NewsListPresenter.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/07.
//

import UIKit

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

  private var currentKeyword = "아이폰"
  private var currentPage: Int = 0
  private let display: Int = 20

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
    requestNewsList(isNeededToReset: true)
  }

  func didCalledRefresh() {
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
extension NewsListPresenter: UITableViewDataSource, UITableViewDelegate {
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

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    148.0
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
private extension NewsListPresenter {
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
