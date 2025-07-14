//
//  ErrorAlertMessage.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/8/25.
// MARK: Alert

import UIKit

enum AlertType {
  case noData
  case emptyInput
  case nonNumericInput
}

enum AlertFactory {
  static func makeAlert(_ type: AlertType) -> UIAlertController {
    let (title, message): (String, String) = {
      switch type {
      case .noData: return ("오류", "데이터를 불러올 수 없습니다")
      case .emptyInput: return ("오류", "금액을 입력해주세요")
      case .nonNumericInput: return ("오류", "올바른 숫자를 입력해주세요")
      }
    }()
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    return alert
  }
}

