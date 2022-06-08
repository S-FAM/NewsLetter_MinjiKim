//
//  NewsListCollectionViewCell.swift
//  NewsLetter
//
//  Created by 김민지 on 2022/06/07.
//

import SnapKit
import UIKit

final class NewsListCollectionViewCell: UICollectionViewCell {
  static let identifier = "NewsListCollectionViewCell"

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 10.0, weight: .medium)
    label.textColor = UIColor(named: "AccentColor")

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
    label.numberOfLines = 0

    return label
  }()

  func update() {
    setupView()

    dateLabel.text = "2016.09.26"
    titleLabel.text = "국내 주식형펀드서 사흘째 자금 순유출"
    descriptionLabel.text = "국내 주식형 펀드에서 사흘째 자금이 빠져나갔다. 26일 금융투자협회에 따르면 지난 22일 상장지수펀드(ETF)를 제외한 국내 주식형 펀드에서 126억원이 순유출됐다. 472억원이 들어오고 598억원이 펀드..."
  }
}

private extension NewsListCollectionViewCell {
  func setupView() {
    backgroundColor = .systemBackground

    layer.cornerRadius = 20.0
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 10.0
    layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

    [dateLabel, titleLabel, descriptionLabel].forEach {
      addSubview($0)
    }

    let inset: CGFloat = 16.0

    dateLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(inset)
    }

    titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(inset)
      $0.top.equalTo(dateLabel.snp.bottom).offset(8.0)
    }

    descriptionLabel.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview().inset(inset)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
    }
  }
}
