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
  
  private let currencyCodeLabel: UILabel = { // 통화 코드
    let label = UILabel()
    label.text = "KRW"
    label.textColor = .label
    return label
  }()
  
  private let exchangeRateLabel: UILabel = { // 환율
    let label = UILabel()
    label.text = "10123"
    label.textColor = .label
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
    [currencyCodeLabel, exchangeRateLabel].forEach {
      contentView.addSubview($0)
    }
    
    currencyCodeLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(16)
    }
    
    exchangeRateLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(16)
    }
  }
  
  func configureCell(currency: CurrencyItem) {
    currencyCodeLabel.text = "\(currency.code)"
    exchangeRateLabel.text = String(format: "%.4f", currency.rate)
  }
}
