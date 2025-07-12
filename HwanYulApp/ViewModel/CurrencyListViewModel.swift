//
//  CurrencyListViewModel.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/11/25.
//

//import Foundation // UIKit은 UI관련이라 안되지만, Foundation은 로직을 위한 프레임워크이기에 가능

enum CurrencyListAction { // View(VC)가 ViewModel에게 동작을 해달라 요청.
  case loadData
  case search(String)
  case toggleFavorite(CurrencyItem)
}

enum CurrencyListState {
  case success([CurrencyItem]) // 성공
  case failure // 실패
}

final class CurrencyListViewModel: ViewModelProtocol {
  typealias Action = CurrencyListAction
  typealias State = CurrencyListState
  
  var state: State = .failure { // View모델이 가지고 있는 상태 (초기값 .failure)
    didSet { // state 값이 변겨오디면 didSet이 실행됨
      stateDidChange?(state)
    }
  }
  
  var stateDidChange: ((State) -> Void)?
  private var allCurrencyItems: [CurrencyItem] = [] // 원본 데이터 저장
  
  // MARK: - action
  func action(_ action: Action) {
    switch action {
    case .loadData:
      fetchCurrencyData()
    case .search(let keyword):
      filterCurrency(keyword: keyword)
    case .toggleFavorite(let item): // item에는 몇번째 셀이 눌린건지에 대한 정보
      toggleFavorite(item)
    }
  }
  
  // MARK: - 환율 데이터 불러오기(정렬도) 후 상태 전달
  private func fetchCurrencyData() {
    DataService().fetchCurrencyData { [weak self] result in
      guard let self else { return }
      
      let sortedItems = result.items.sorted { $0.code.lowercased() < $1.code.lowercased() }
      self.allCurrencyItems = sortedItems
      self.state = .success(sortedItems)
    }
  }
  
  // MARK: - 환율 데이터 필터링 후 전달
  private func filterCurrency(keyword: String) {
    if keyword.isEmpty { // 비어있으면 allCurrencyItems로 정리한 환율 데이터
      self.state = .success(allCurrencyItems)
    } else { // 있으면 filter(코드나 국가명)해서 포함하는 환율 데이터만
      let filtered = allCurrencyItems.filter {
        $0.code.lowercased().contains(keyword) ||
        $0.countryName.lowercased().contains(keyword)
      }
      self.state = .success(filtered)
    }
  }
  
  private func toggleFavorite(_ item: CurrencyItem) {
    guard let index = allCurrencyItems.firstIndex(where: { $0.code == item.code}) else { return }
    
    allCurrencyItems[index].isFavorite.toggle()
    
    let sorted = allCurrencyItems.sorted {
      if $0.isFavorite == $1.isFavorite { // 즐겨찾기된 데이터들 알파벳 오름차순 정렬
        return $0.code < $1.code
      } else { // 아니라면 즐겨찾기 데이터 먼저 배치
        return $0.isFavorite && !$1.isFavorite
      }
    }
    
    self.state = .success(sorted)
  }
}
