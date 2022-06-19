//
//  NewsListTableViewHeader.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/19.
//

import UIKit

protocol NewsListTableViewHeaderDelegate: AnyObject {
  func didSelectTag(_ selectedIndex: Int)
}

final class NewsListTableViewHeader: UITableViewHeaderFooterView {
  static let identifier = "NewsListTableViewHeader"

  private weak var delegate: NewsListTableViewHeaderDelegate?

  private var tags: [String] = []

  private lazy var collectionView: UICollectionView = {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.showsHorizontalScrollIndicator = false

    collectionView.register(
      TagCell.self,
      forCellWithReuseIdentifier: TagCell.identifier
    )

    return collectionView
  }()

  func setupView(tags: [String], delegate: NewsListTableViewHeaderDelegate) {
    self.tags = tags
    self.delegate = delegate

    addSubview(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - UICollectionView
extension NewsListTableViewHeader: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    tags.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath)
  -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TagCell.identifier,
      for: indexPath
    ) as? TagCell else { return UICollectionViewCell() }

    cell.setupView(tags[indexPath.row])

    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    CGSize(width: 50.0, height: 25.0)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    delegate?.didSelectTag(indexPath.row)
  }
}

// MARK: - TagCell
final class TagCell: UICollectionViewCell {
  static let identifier = "TagCell"

  private lazy var roundRectangleView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "AccentColor")
    view.layer.cornerRadius = 12.0

    return view
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 12.0, weight: .bold)

    return label
  }()

  func setupView(_ text: String) {
    [roundRectangleView, titleLabel].forEach {
      addSubview($0)
    }

    roundRectangleView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }

    titleLabel.text = text
  }
}
