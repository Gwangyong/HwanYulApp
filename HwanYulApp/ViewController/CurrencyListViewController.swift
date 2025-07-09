//
//  ViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/7/25.
// MARK: 화면 전체 제어

import UIKit

class CurrencyListViewController: UIViewController {
  
  private var dataSource: [CurrencyItem] = [] // 튜플을 여러개 담은 배열
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "통화 검색"
    searchBar.searchBarStyle = .minimal
    return searchBar
  }()
  
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
    [searchBar, tableView].forEach {
      view.addSubview($0)
    }
    tableView.rowHeight = 60 // 2줄에 아이콘도 있기에 Cell 크기를 60 고정
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: - fetchAndBindCurrencyData
  // 환율 데이터를 가져와서 바인딩하는 메서드
  private func fetchAndBindCurrencyData() {
    DataService().fetchCurrencyData { [weak self] currency in
      guard let self else { return }
      
      DispatchQueue.main.async { // UI 관련 작업들 메인 스레드에서 실행
        // 데이터가 비어있을 경우 Alert 표시
        if currency.items.isEmpty {
          let alert = AlertFactory.noDataAlert()
          self.present(alert, animated: true)
        } else {
          // 소문자로 변경해서 반복 비교
          self.dataSource = currency.items.sorted { $0.code.lowercased() < $1.code.lowercased() }
          self.tableView.reloadData() // UI랑 관련있는 UI 업데이트라 메인 스레드에서 수행
        }
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
    cell.configureCell(currency: dataSource[indexPath.row])
    return cell
  }
}

// MARK: - Delegate
extension CurrencyListViewController: UITableViewDelegate { }
