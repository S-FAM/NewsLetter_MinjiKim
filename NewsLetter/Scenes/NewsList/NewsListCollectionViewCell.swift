//
//  NewsListCollectionViewCell.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/07.
//

import Kingfisher
import SnapKit
import UIKit

final class NewsListCollectionViewCell: UICollectionViewCell {
  static let identifier = "NewsListCollectionViewCell"

  private let cornerRadius: CGFloat = 20.0

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 10.0, weight: .medium)
    label.textColor = UIColor(named: "AccentColor")
    label.backgroundColor = UIColor(named: "SubColor")
    label.textAlignment = .center
    label.layer.cornerRadius = 12.0
    label.clipsToBounds = true

    return label
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14.0, weight: .bold)

    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 10.0, weight: .regular)
    label.numberOfLines = 3

    return label
  }()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = cornerRadius
    imageView.clipsToBounds = true

    return imageView
  }()

  func update(news: News) {
    setupView()

    let date = String(Array(news.publishedAt).prefix(upTo: 10))
    dateLabel.text = date.replacingOccurrences(of: "-", with: ".")
    titleLabel.text = news.title
    descriptionLabel.text = news.description

    guard let imageUrl = URL(string: news.urlToImage ?? "") else { return }
    imageView.kf.setImage(with: imageUrl)
  }
}

private extension NewsListCollectionViewCell {
  func setupView() {
    backgroundColor = .systemBackground

    layer.cornerRadius = cornerRadius
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 10.0
    layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

    [imageView, dateLabel, titleLabel, descriptionLabel].forEach {
      addSubview($0)
    }

    let inset: CGFloat = 16.0
    let spacing: CGFloat = 8.0

    imageView.snp.makeConstraints {
      $0.width.height.equalTo(100.0)
      $0.leading.equalToSuperview().inset(inset)
      $0.centerY.equalToSuperview()
    }

    dateLabel.snp.makeConstraints {
      $0.width.equalTo(73.0)
      $0.height.equalTo(25.0)
      $0.leading.equalTo(imageView.snp.trailing).offset(spacing)
      $0.top.equalTo(imageView.snp.top)
    }

    titleLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(inset)
      $0.leading.equalTo(imageView.snp.trailing).offset(spacing)
      $0.top.equalTo(dateLabel.snp.bottom).offset(spacing)
    }

    descriptionLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(inset)
      $0.leading.equalTo(imageView.snp.trailing).offset(spacing)
      $0.top.equalTo(titleLabel.snp.bottom).offset(spacing)
      $0.bottom.equalTo(imageView.snp.bottom)
    }
  }
}
