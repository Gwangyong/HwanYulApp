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
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super .init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
