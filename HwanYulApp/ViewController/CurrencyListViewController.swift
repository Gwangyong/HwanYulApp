//
//  ViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/7/25.
// MARK: 화면 전체 제어

import UIKit

class CurrencyListViewController: UIViewController {
  
  private var dataSource: [CurrencyItem] = [] // 화면 표시 데이터
  private var allCurrencyItems: [CurrencyItem] = [] // 원본 데이터 저장
  
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "통화 검색"
    searchBar.searchBarStyle = .minimal
    searchBar.delegate = self
    return searchBar
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = CurrencyListCell.height // 60
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.identifier)
    return tableView
  }()
  
  private let resultLabel: UILabel = {
    let label = UILabel()
    label.text = "검색 결과 없음"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.textColor = .label
    label.isHidden = true
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureLayout()
    fetchAndBindCurrencyData()
  }
  
  // MARK: - configureViews
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    [searchBar, tableView, resultLabel].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - configureLayout
  private func configureLayout() {
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    resultLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
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
          let sortedItems = currency.items.sorted { $0.code.lowercased() < $1.code.lowercased() }
          self.dataSource = sortedItems
          self.allCurrencyItems = sortedItems
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
extension CurrencyListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = CurrencyCalculatorViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension CurrencyListViewController: UISearchBarDelegate {
  // UISearchBarDelegate 프로토콜에 정의된 메서드.
  // 검색바 텍스트가 바뀔 때마다 자동 호출되는 콜백 함수
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let searchKeyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() // 공백,\n등 제거, 소문자.
    
    if searchKeyword.isEmpty { // 공백이라면 초기 상태로
      dataSource = allCurrencyItems
    } else {
      dataSource = allCurrencyItems.filter {
        // code나 countryName 중 하나라도 textLine이 포함되어 있는게 있다면 그 항목만 필터링해서 dataSource에 넣음
        // contains. 포함이므로, 맨 앞이 아니라 어느 위치든 포함되면 true
        $0.code.lowercased().contains(searchKeyword) ||
        $0.countryName.lowercased().contains(searchKeyword)
      }
    }
    
    // dataSource가 비어있으면 tableView를 숨기고, resultLabel을 보여줌.
    let isEmpty = dataSource.isEmpty
    tableView.isHidden = isEmpty
    resultLabel.isHidden = !isEmpty
    tableView.reloadData()
  }
}
