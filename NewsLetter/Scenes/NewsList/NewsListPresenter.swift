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
}

final class NewsListPresenter: NSObject {
  private weak var viewController: NewsListProtocol?

  init(viewController: NewsListProtocol) {
    self.viewController = viewController
  }

  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupView()
  }
}

// MARK: - UICollectionView
extension NewsListPresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 10
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: NewsListCollectionViewCell.identifier,
      for: indexPath
    ) as? NewsListCollectionViewCell else { return UICollectionViewCell() }

    cell.update()

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let spacing: CGFloat = 16.0
    let width = collectionView.frame.width - spacing * 2
    return CGSize(width: width, height: 125.0)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    let inset: CGFloat = 16.0
    return UIEdgeInsets(top: inset, left: 0.0, bottom: inset, right: 0.0)
  }
}
