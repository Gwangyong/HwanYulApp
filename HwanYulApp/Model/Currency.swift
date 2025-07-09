//
//  Currency.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/8/25.
// MARK: 통화 + 환율 정보 모델

// MARK: API 응답 전체를 담는 모델
struct Currency: Codable {
  let baseCode: String
  let rates: [String: Double]
  
  enum CodingKeys: String, CodingKey {
    case baseCode = "base_code"
    case rates
  }
}

// MARK: 셀에서 사용할 모델
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
