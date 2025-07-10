//
//  CurrencyCalculatorViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/9/25.
//

import UIKit
import SnapKit

class CurrencyCalculatorViewController: UIViewController {
  private let labelStackView = UIStackView()
  private let currencyCodeLabel = UILabel()
  private let countryNameLabel = UILabel()
  
  private let amountTextField = UITextField()
  private let convertButton = UIButton()
  private let resultLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureLayout()
  }
  
  // MARK: - configureViews
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    [labelStackView, amountTextField, convertButton, resultLabel].forEach {
      view.addSubview($0)
    }
    
    [currencyCodeLabel, countryNameLabel].forEach {
      labelStackView.addArrangedSubview($0)
    }
    
    configureLabelStackView()
    configureCurrencyCodeLabel()
    configureCountryNameLabel()
    configureAmountTextField()
    configureConvertButton()
    configureResultLabel()
  }
  
  private func configureLabelStackView() {
    labelStackView.axis = .vertical
    labelStackView.spacing = 4
    labelStackView.alignment = .center
  }
  
  private func configureCurrencyCodeLabel() {
    currencyCodeLabel.font = .systemFont(ofSize: 24, weight: .bold)
  }
  
  private func configureCountryNameLabel() {
    countryNameLabel.font = .systemFont(ofSize: 16)
    countryNameLabel.textColor = .gray
  }
  
  private func configureAmountTextField() {
    amountTextField.borderStyle = .roundedRect // 외각선을 둥근 사각형 스타일로 설정
    amountTextField.keyboardType = .decimalPad // 소수점 입력용 키보드 표시
    amountTextField.textAlignment = .center
    amountTextField.placeholder = "금액을 입력하세요"
  }
  
  private func configureConvertButton() {
    convertButton.backgroundColor = .systemBlue
    convertButton.setTitle("환율 계산", for: .normal)
    convertButton.setTitleColor(.white, for: .normal)
    convertButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    convertButton.layer.cornerRadius = 8
    convertButton.clipsToBounds = true
  }
  
  private func configureResultLabel() {
    resultLabel.text = "계산 결과가 여기에 표시됩니다"
    resultLabel.font = .systemFont(ofSize: 20, weight: .medium)
    resultLabel.textAlignment = .center
    resultLabel.numberOfLines = 0
  }
  
  // MARK: - configureLayout
  private func configureLayout() {
    labelStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
      $0.centerX.equalToSuperview()
    }
    
    amountTextField.snp.makeConstraints {
      $0.top.equalTo(labelStackView.snp.bottom).offset(32)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
      $0.height.equalTo(44)
    }
    
    convertButton.snp.makeConstraints {
      $0.top.equalTo(amountTextField.snp.bottom).offset(24)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
      $0.height.equalTo(44)
    }
    
    resultLabel.snp.makeConstraints {
      $0.top.equalTo(convertButton.snp.bottom).offset(32)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
  }
}
