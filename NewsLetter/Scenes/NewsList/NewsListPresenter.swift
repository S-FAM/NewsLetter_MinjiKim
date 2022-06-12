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

  func reloadCollectionView()
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
}

// MARK: - UICollectionView
extension NewsListPresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return newsList.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: NewsListCollectionViewCell.identifier,
      for: indexPath
    ) as? NewsListCollectionViewCell else { return UICollectionViewCell() }

    let news = newsList[indexPath.row]
    cell.update(news: news)

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let spacing: CGFloat = 16.0
    let width = collectionView.frame.width - spacing * 2
    return CGSize(width: width, height: 132.0)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    let inset: CGFloat = 16.0
    return UIEdgeInsets(top: inset, left: 0.0, bottom: inset, right: 0.0)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    let currentRow = indexPath.row
    guard (currentRow % display) == (display - 3) &&
            (currentRow / display) == (currentPage - 1) else { return }

    requestNewsList(isNeededToReset: false)
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
      self.viewController?.reloadCollectionView()
    }
  }
}
