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
  
  // MARK: - ViewModel
  let viewModel = CurrencyCalculatorViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureLayout()
    bindViewModel()
    setupActions()
  }
  
  // MARK: - ViewModel Binding
  private func bindViewModel() {
    viewModel.stateDidChange = { [weak self] state in
      guard let self else { return }
      
      DispatchQueue.main.async {
        switch state {
        case .result(let resultText):
          self.resultLabel.text = resultText
          self.amountTextField.text = ""
        case .error(let alertType):
          let alert = AlertFactory.makeAlert(alertType)
          self.present(alert, animated: true)
          self.amountTextField.text = ""
        @unknown default: // 누락된 case 대비하여 안전히 처리해줌
          break
        }
      }
    }
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
    currencyCodeLabel.text = viewModel.currencyItem?.code
    currencyCodeLabel.font = .systemFont(ofSize: 24, weight: .bold)
  }
  
  private func configureCountryNameLabel() {
    countryNameLabel.text = viewModel.currencyItem?.countryName
    countryNameLabel.font = .systemFont(ofSize: 16)
    countryNameLabel.textColor = .gray
  }
  
  private func configureAmountTextField() {
    amountTextField.borderStyle = .roundedRect // 외각선을 둥근 사각형 스타일로 설정
    amountTextField.keyboardType = .decimalPad // 소수점 입력용 키보드 표시
    amountTextField.textAlignment = .center
    amountTextField.attributedPlaceholder = NSAttributedString( // 다크모드 대응을 위해 색상 적용
      string: "달러(USD)를 입력하세요",
      attributes: [.foregroundColor: UIColor.secondaryLabel] // 글자 색상 속성
      )
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
  
  private func setupActions() {
    convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
  }
  
  @objc private func convertButtonTapped() {
    let inputText = amountTextField.text ?? ""
    viewModel.action?(.convertButtonTapped(inputText: inputText))
  }
}
