//
//  ErrorAlertMessage.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/8/25.
// MARK: Alert

import UIKit

enum AlertFactory {
  static func noDataAlert() -> UIAlertController {
    let alert = UIAlertController(title: "에러", message: "데이터를 불러올 수 없습니다.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    return alert
  }
}
