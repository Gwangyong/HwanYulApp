//
//  ViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/7/25.
// MARK: 화면 전체 제어

import UIKit

class CurrencyListViewController: UIViewController {
  
  private var dataSource: [(code: String, rate: Double)] = [] // 튜플을 여러개 담은 배열
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.identifier)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchAndBindCurrencyData()
  }
  
  // MARK: - configureUI
  private func configureUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.directionalEdges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: - fetchAndBindCurrencyData
  private func fetchAndBindCurrencyData() {
    DataService().fetchCurrencyData { [weak self] currency in
      guard let self else { return }
      
      self.dataSource = currency.rates.map { (key, value) in // 순서 있는 튜플 배열로 변경
        (code: key, rate: value)
      }
    }
  }
}

// MARK: - DataSource
extension CurrencyListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.identifier) as? CurrencyListCell else { return UITableViewCell() }
    // TODO: Cell에 configure
    return cell
  }
}

// MARK: - Delegate
extension CurrencyListViewController: UITableViewDelegate {
  
}
