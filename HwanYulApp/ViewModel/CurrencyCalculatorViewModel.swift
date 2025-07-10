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
  case idle // 초기상태
  case result(String) // 계산 결과 텍스트
  case error(AlertType) // 에러 알림 타입
}

final class CurrencyCalculatorViewModel: ViewModelProtocol {
  typealias Action = CalculatorAction
  typealias State = CalculatorState

  var currencyItem: CurrencyItem?

  var state: CalculatorState = .idle {
    didSet {
      stateDidChange?(state)
    }
  }

  var action: ((CalculatorAction) -> Void)? // VC가 ViewModel에게 행동 요청할때 사용
  var stateDidChange: ((CalculatorState) -> Void)? // ViewModel에서 VC에게 상태를 알려줄때 사용

  init() { // ViewModel이 생성되자마자 있어야 VC에서 이벤트 던지기 가능하기에 init
    action = { [weak self] action in
      self?.handle(action)
    }
  }

  private func handle(_ action: CalculatorAction) {
    switch action {
    case .convertButtonTapped(let inputText):
      self.convert(inputText: inputText)
    }
  }

  private func convert(inputText: String) {
    guard !inputText.isEmpty else {
      state = .error(.emptyInput)
      return
    }

    guard let amount = Double(inputText) else {
      state = .error(.nonNumericInput)
      return
    }

    // 값이 왔으니, 그걸 가지고 계산해서 띄워주는.
    guard let rate = currencyItem?.rate else { return }

    let result = amount * rate // 입력값 * 환율
    let formattedAmount = String(format: "%.2f", amount) // 소수점 2자리로 반올림
    let formattedResult = String(format: "%.2f", result)
    let resultText = "$\(formattedAmount) → \(formattedResult) \(currencyItem?.code ?? "")"

    state = .result(resultText)
  }
}
