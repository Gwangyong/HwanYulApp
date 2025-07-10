//
//  CurrencyItem.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/10/25.
//


// MARK: 뷰에 표시할 셀에서 사용할 모델
struct CurrencyItem {
  let code: String
  let rate: Double
  
  var countryName: String {
    CurrencyCountryMap.mapping[code] ?? "데이터에 없는 나라입니다."
  }
}

// MARK: Currency -> [CurrencyItem]으로 변환
extension Currency {
  var items: [CurrencyItem] {
    rates.map { CurrencyItem(code: $0.key, rate: $0.value) }
    }
}
