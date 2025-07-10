//
//  CurrencyCalculatorViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/9/25.
//

import UIKit
import SnapKit

class CurrencyCalculatorViewController: UIViewController {
  private let titleLabel = UILabel()
  private let labelStackView = UIStackView()
  private let currencyCodeLabel = UILabel()
  private let countryNameLabel = UILabel()
  private let amountTextField = UITextField()
  private let convertButton = UIButton()
  private let resultLabel = UILabel()
  
  var currencyItem: CurrencyItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureLayout()
  }
  
  // MARK: - configureViews
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    [titleLabel, labelStackView, amountTextField, convertButton, resultLabel].forEach {
      view.addSubview($0)
    }
    
    [currencyCodeLabel, countryNameLabel].forEach {
      labelStackView.addArrangedSubview($0)
    }
    
    configureTitleLabel()
    configureLabelStackView()
    configureCurrencyCodeLabel()
    configureCountryNameLabel()
    configureAmountTextField()
    configureConvertButton()
    configureResultLabel()
  }
  
  private func configureTitleLabel() {
    titleLabel.text = "환율 계산기"
    titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
    titleLabel.textAlignment = .left
  }
  
  private func configureLabelStackView() {
    labelStackView.axis = .vertical
    labelStackView.spacing = 4
    labelStackView.alignment = .center
  }
  
  private func configureCurrencyCodeLabel() {
    currencyCodeLabel.text = currencyItem?.code
    currencyCodeLabel.font = .systemFont(ofSize: 24, weight: .bold)
  }
  
  private func configureCountryNameLabel() {
    countryNameLabel.text = currencyItem?.countryName
    countryNameLabel.font = .systemFont(ofSize: 16)
    countryNameLabel.textColor = .gray
  }
  
  private func configureAmountTextField() {
    amountTextField.borderStyle = .roundedRect // 외각선을 둥근 사각형 스타일로 설정
    amountTextField.keyboardType = .decimalPad // 소수점 입력용 키보드 표시
    amountTextField.textAlignment = .center
    amountTextField.placeholder = "달러(USD)를 입력하세요"
  }
  
  private func configureConvertButton() {
    convertButton.backgroundColor = .systemBlue
    convertButton.setTitle("환율 계산", for: .normal)
    convertButton.setTitleColor(.white, for: .normal)
    convertButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    convertButton.layer.cornerRadius = 8
    convertButton.clipsToBounds = true
    convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
  }
  
  private func configureResultLabel() {
    resultLabel.text = "계산 결과가 여기에 표시됩니다"
    resultLabel.font = .systemFont(ofSize: 20, weight: .medium)
    resultLabel.textAlignment = .center
    resultLabel.numberOfLines = 0
  }
  
  // MARK: - configureLayout
  private func configureLayout() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
      $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
    }
    
    labelStackView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(32)
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
  
  @objc private func convertButtonTapped() {
    // 다 하고, try catch로 예외처리? 지금 이것도 예외처리가 맞는거같긴한데
    // 달러일때는 달러. krw일때는 krw로
    
    // 입력값 체크
    guard let inputText = amountTextField.text, !inputText.isEmpty else {
      let alert = AlertFactory.makeAlert(.emptyInput)
      self.present(alert, animated: true)
      return
    }
    
    guard let amount = Double(inputText) else {
      let alert = AlertFactory.makeAlert(.nonNumericInput)
      self.present(alert, animated: true)
      amountTextField.text = ""
      return
    }
    
    // 값이 왔으니, 그걸 가지고 계산해서 띄워주는.
    guard let rate = currencyItem?.rate else { return }
    let result = amount * rate // 입력값 * 환율
    let formattedRate = String(format: "%.2f", amount)
    let formattedResult = String(format: "%.2f", result) // 소수점 2자리로 반올림
    resultLabel.text = "$\(formattedRate) → \(formattedResult) \(currencyItem?.code ?? "")"
  }
}
