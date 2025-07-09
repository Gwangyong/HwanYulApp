//
//  CurrencyListCell.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/8/25.
// MARK: 셀 UI

import UIKit
import SnapKit

final class CurrencyListCell: UITableViewCell {
  
  static let identifier = "CurrencyListCell"
  
  private let labelStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    return stackView
  }()
  
  private let currencyCodeLabel: UILabel = { // 통화 코드
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    return label
  }()
  
  private let countryNameLabel: UILabel = { // 국가명
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.textColor = .gray
    return label
  }()
  
  private let exchangeRateLabel: UILabel = { // 환율
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super .init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - configureUI
  private func configureUI() {
    [labelStackView, exchangeRateLabel].forEach {
      contentView.addSubview($0)
    }
    
    [currencyCodeLabel, countryNameLabel].forEach {
      labelStackView.addArrangedSubview($0)
    }
    
    contentView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
      // 높이 60은 tableView.rowHeight = 60을 주었음
    }
    
    labelStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    
    exchangeRateLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(16)
      $0.leading.greaterThanOrEqualTo(labelStackView.snp.trailing).offset(16)
    }
  }
  
  func configureCell(currency: CurrencyItem) {
    currencyCodeLabel.text = "\(currency.code)"
    exchangeRateLabel.text = String(format: "%.4f", currency.rate)
    countryNameLabel.text = "\(currency.countryName)"
  }
}
