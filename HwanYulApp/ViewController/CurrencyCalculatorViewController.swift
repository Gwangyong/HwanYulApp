//
//  CurrencyCalculatorViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/9/25.
//

import UIKit
import SnapKit

class CurrencyCalculatorViewController: UIViewController {
  
  private let labelStackView: UIStackView = { // 통화코드 + 국가명 스택뷰
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .center
    return stackView
  }()
  
  private let currencyCodeLabel: UILabel = { // 통화 코드
    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .bold)
    return label
  }()
  
  private let countryNameLabel: UILabel = { // 국가명
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.textColor = .gray
    return label
  }()
  
  private let amountTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect // 외각선을 둥근 사각형 스타일로 설정
    textField.keyboardType = .decimalPad // 소수점 입력용 키보드 표시
    textField.textAlignment = .center
    textField.placeholder = "금액을 입력하세요"
    return textField
  }()
  
  private let convertButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
    return button
  }()
  
  private let resultLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    view.backgroundColor = .systemBackground
    [labelStackView, amountTextField, convertButton, resultLabel].forEach {
      view.addSubview($0)
    }
    
    [currencyCodeLabel, countryNameLabel].forEach {
      labelStackView.addArrangedSubview($0)
    }
    
    labelStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
      $0.centerX.equalToSuperview()
    }
    
    amountTextField.snp.makeConstraints {
      $0.top.equalTo(labelStackView.snp.bottom).offset(32)
      $0.leading.trailing.equalToSuperview().inset(24)
      $0.height.equalTo(44)
    }
    
    convertButton.snp.makeConstraints {
      $0.top.equalTo(amountTextField.snp.bottom).offset(24)
      $0.leading.trailing.equalToSuperview().inset(24)
      $0.height.equalTo(44)
    }
    
    resultLabel.snp.makeConstraints {
      $0.top.equalTo(convertButton.snp.bottom).offset(32)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
  }
}
