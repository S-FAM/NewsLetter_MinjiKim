//
//  NewsListTableViewCell.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/07.
//

import UIKit

final class NewsListTableViewCell: UITableViewCell {
  static let identifier = "NewsListTableViewCell"

  private let cornerRadius: CGFloat = 20.0
  private let inset: CGFloat = 16.0
  private let spacing: CGFloat = 8.0

  private lazy var roundRectangleView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = cornerRadius

    return view
  }()

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
    label.numberOfLines = 0

    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 10.0, weight: .regular)
    label.numberOfLines = 3

    return label
  }()

  func update(news: News) {
    setupView()

    dateLabel.text = convertDateFormat(news.pubDate)
    titleLabel.text = news.title.htmlToString
    descriptionLabel.text = news.description.htmlToString
  }
}

private extension NewsListTableViewCell {
  func setupView() {
    selectionStyle = .none
    backgroundColor = .clear

    addSubview(roundRectangleView)

    [dateLabel, titleLabel, descriptionLabel].forEach {
      roundRectangleView.addSubview($0)
    }

    roundRectangleView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(inset)
      $0.top.bottom.equalToSuperview().inset(spacing)
    }

    dateLabel.snp.makeConstraints {
      $0.width.equalTo(73.0)
      $0.height.equalTo(25.0)
      $0.leading.top.equalToSuperview().inset(inset)
    }

    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(dateLabel.snp.leading)
      $0.trailing.equalToSuperview().inset(inset)
      $0.top.equalTo(dateLabel.snp.bottom).offset(spacing)
    }

    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel.snp.leading)
      $0.trailing.equalTo(titleLabel.snp.trailing)
      $0.top.equalTo(titleLabel.snp.bottom).offset(spacing)
      $0.bottom.equalToSuperview().inset(inset)
    }
  }

  func convertDateFormat(_ pubDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"

    let convertDate = dateFormatter.date(from: pubDate)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"

    return formatter.string(from: convertDate!)
  }
}
