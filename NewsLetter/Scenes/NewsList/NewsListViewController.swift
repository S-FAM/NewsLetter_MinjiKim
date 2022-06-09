//
//  NewsListViewController.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/06.
//

import SnapKit
import UIKit

final class NewsListViewController: UIViewController {
  private lazy var presenter = NewsListPresenter(viewController: self)

  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = false

    return searchController
  }()

  private lazy var collectionView: UICollectionView = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.minimumLineSpacing = 16.0

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    collectionView.dataSource = presenter
    collectionView.delegate = presenter
    collectionView.backgroundColor = .secondarySystemBackground

    collectionView.register(
      NewsListCollectionViewCell.self,
      forCellWithReuseIdentifier: NewsListCollectionViewCell.identifier
    )

    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

// MARK: - NewsListProtocol Function
extension NewsListViewController: NewsListProtocol {
  func setupNavigationBar() {
    navigationItem.title = "News"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always

    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }

  func setupView() {
    view.addSubview(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func reloadCollectionView() {
    collectionView.reloadData()
  }
}
