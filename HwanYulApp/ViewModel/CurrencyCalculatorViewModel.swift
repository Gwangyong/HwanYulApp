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
  case ready(code: String, country: String) // 준비된 상태. 기본데이터
  case result(String) // 계산 결과 텍스트
  case error(AlertType) // 에러 알림 타입
}

final class CurrencyCalculatorViewModel: ViewModelProtocol {
  typealias Action = CalculatorAction
  typealias State = CalculatorState

  var state: State = .ready(code: "", country: "") {
    didSet {
      stateDidChange?(state)
    }
  }

  // MARK: - 상태 전달
  var stateDidChange: ((State) -> Void)? // ViewModel에서 VC에게 상태를 알려줄때 사용
  // FIXME: VC의 FIXME 수정하고 private으로 설정
  var currencyItem: CurrencyItem?

  // MARK: - action
  func action(_ action: Action) {
    switch action {
    case .convertButtonTapped(let inputText):
      convert(inputText: inputText)
    }
  }

  // MARK: - 환율 계산 로직
  private func convert(inputText: String) {
    guard let amount = Double(inputText), !inputText.isEmpty else { // 비어있지 않고, Double일 경우
      state = inputText.isEmpty ? .error(.emptyInput) : .error(.nonNumericInput)
      return
    }

    guard let currencyItem else {
      state = .error(.emptyInput)
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
