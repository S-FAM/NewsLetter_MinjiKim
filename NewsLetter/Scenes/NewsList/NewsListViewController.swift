//
//  NewsListViewController.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/06.
//

import SafariServices
import UIKit

final class NewsListViewController: UIViewController {
  private lazy var presenter = NewsListPresenter(viewController: self)

  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(didCallRefresh), for: .valueChanged)

    return refreshControl
  }()

  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = presenter

    return searchController
  }()

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = presenter
    tableView.delegate = presenter
    tableView.backgroundColor = .secondarySystemBackground
    tableView.separatorStyle = .none

    tableView.register(
      NewsListTableViewCell.self,
      forCellReuseIdentifier: NewsListTableViewCell.identifier
    )

    tableView.refreshControl = refreshControl
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()

    tableView.isSkeletonable = true
    tableView.showAnimatedSkeleton(usingColor: .concrete, transition: .crossDissolve(0.25))

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.presenter.requestNewsList(isNeededToReset: true)
      self.tableView.stopSkeletonAnimation()
      self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
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
    view.addSubview(tableView)

    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func reloadTableView() {
    tableView.reloadData()
  }

  func endRefreshing() {
    refreshControl.endRefreshing()
  }

  func openSFSafariView(_ url: String) {
    guard let url = URL(string: url) else { return }

    let safariView = SFSafariViewController(url: url)
    present(safariView, animated: true, completion: nil)
  }
}

// MARK: - @objc Function
private extension NewsListViewController {
  @objc func didCallRefresh() {
    presenter.didCalledRefresh()
  }
}
