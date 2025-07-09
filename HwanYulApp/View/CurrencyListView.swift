//
//  Untitled.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/9/25.
//

import UIKit
import SnapKit

final class CurrencyListView: UIView {
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 60 // 2줄에 아이콘도 있기에 Cell 크기를 60 고정
    tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.identifier)
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - configureUI
  private func configureUI() {
    backgroundColor = .white
    addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
  }
}
