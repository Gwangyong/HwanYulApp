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
  static let height: CGFloat = 60
  
  var onStarTapped: (() -> Void)?
  
  private let labelStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    return stackView
  }()
  
  private let currencyCodeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    return label
  }()
  
  private let countryNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.textColor = .gray
    return label
  }()
  
  private let currencyRateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  
  private let isStarButton: UIButton = {
    let button = UIButton()
    button.tintColor = .systemYellow
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super .init(style: style, reuseIdentifier: reuseIdentifier)
    configureViews()
    configureLayout()
    setupActions()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - configureViews
  private func configureViews() {
    [labelStackView, currencyRateLabel, isStarButton].forEach {
      contentView.addSubview($0)
    }
    
    [currencyCodeLabel, countryNameLabel].forEach {
      labelStackView.addArrangedSubview($0)
    }
  }
  
  // MARK: - configureLayout
  private func configureLayout() {
    labelStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    
    currencyRateLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalTo(isStarButton.snp.leading).offset(-12)
      $0.leading.greaterThanOrEqualTo(labelStackView.snp.trailing).offset(16)
    }
    
    isStarButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(16)
    }
  }
  
  func configureCell(currency: CurrencyItem) {
    currencyCodeLabel.text = "\(currency.code)"
    currencyRateLabel.text = String(format: "%.4f", currency.rate)
    countryNameLabel.text = "\(currency.countryName)"
    
    let imageName = currency.isFavorite ? "star.fill" : "star"
    isStarButton.setImage(UIImage(systemName: imageName), for: .normal)
  }
  
  private func setupActions() {
    isStarButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
  }
  
  @objc private func starButtonTapped() {
    onStarTapped?()
  }
}
