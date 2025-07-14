//
//  CurrencyCalculatorViewModel.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/10/25.
//

enum CalculatorAction {
  case convertButtonTapped(inputText: String)
}

enum CalculatorState {
  case result(String) // 계산 결과 텍스트
  case error(AlertType) // 에러 알림 타입
}

final class CurrencyCalculatorViewModel: ViewModelProtocol {
  typealias Action = CalculatorAction
  typealias State = CalculatorState
  
  var state: State = .result("계산 결과가 여기에 표시됩니다") {
    didSet {
      stateDidChange?(state)
    }
  }
  
  // MARK: - 상태 전달
  var stateDidChange: ((State) -> Void)? // ViewModel에서 VC에게 상태를 알려줄때 사용
  private let currencyItem: CurrencyItem
  
  // currencyItem을 private하기 위해 필요한 일부만 공개
  var codeText: String {
    currencyItem.code
  }
  
  var countryNameText: String {
    currencyItem.countryName
  }
  
  init(currencyItem: CurrencyItem) {
    self.currencyItem = currencyItem
  }
  
  // MARK: - action
  func action(_ action: Action) {
    switch action {
    case .convertButtonTapped(let inputText):
      convert(inputText: inputText)
    }
  }
  
  // MARK: - 환율 계산 로직
  private func convert(inputText: String) {
    guard !inputText.isEmpty, let amount = Double(inputText) else {
      state = inputText.isEmpty ? .error(.emptyInput) : .error(.nonNumericInput)
      return
    }
    
    // 값이 왔으니, 그걸 가지고 계산해서 띄워주는.
    let result = amount * currencyItem.rate // 입력값 * 환율
    let formattedAmount = String(format: "%.2f", amount) // 소수점 2자리로 반올림
    let formattedResult = String(format: "%.2f", result)
    let resultText = "$\(formattedAmount) → \(formattedResult) \(currencyItem.code)"
    
    state = .result(resultText)
  }
}
