//
//  ViewController.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/7/25.
// MARK: 화면 전체 제어

import UIKit

class CurrencyListViewController: UIViewController {
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "환율 정보"
    label.font = .systemFont(ofSize: 28, weight: .bold)
    label.textAlignment = .left
    return label
  }()
  
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
    tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.identifier) // Cell UI 생성이라 View에서
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
  
  private let viewModel = CurrencyListViewModel()
  private var items: [CurrencyItem] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureLayout()
    bindViewModel() // 콜백 먼저 연결
    viewModel.action(.loadData) // API 가져와서 .success 상태 전달
  }
  
  // MARK: - ViewModel Binding
  private func bindViewModel() {
    viewModel.stateDidChange = { [weak self] state in
      guard let self else { return }
      
      DispatchQueue.main.async {
        switch state {
        case .success(let items):
          self.items = items
          let isEmpty = items.isEmpty
          self.tableView.isHidden = isEmpty
          self.resultLabel.isHidden = !isEmpty
          self.tableView.reloadData()
        case .failure:
          let alert = AlertFactory.makeAlert(.noData)
          self.present(alert, animated: true)
        }
      }
    }
  }
  
  // MARK: - configureViews
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    [titleLabel, searchBar, tableView, resultLabel].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - configureLayout
  private func configureLayout() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
      $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
    }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
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
}

// MARK: - DataSource
extension CurrencyListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.identifier) as? CurrencyListCell else { return UITableViewCell() }
    cell.configureCell(currency: items[indexPath.row])
    cell.onStarTapped = { [weak self] in
      guard let self else { return }
      
      let item = items[indexPath.row]
      self.viewModel.action(.toggleFavorite(item))
    }
    return cell
  }
}

// MARK: - Delegate
extension CurrencyListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let selectedItem = items[indexPath.row]
    let vm = CurrencyCalculatorViewModel(currencyItem: selectedItem)
    let vc = CurrencyCalculatorViewController(viewModel: vm)
    navigationItem.backButtonTitle = "환율 정보"
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension CurrencyListViewController: UISearchBarDelegate {
  // UISearchBarDelegate 프로토콜에 정의된 메서드.
  // 검색바 텍스트가 바뀔 때마다 자동 호출되는 콜백 함수
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let searchKeyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() // 공백,\n등 제거, 소문자.
    viewModel.action(.search(searchKeyword))
  }
}
