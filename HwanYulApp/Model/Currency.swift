//
//  Currency.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/8/25.

// MARK: API 응답(통화 + 환율 정보)을 담는 모델
struct Currency: Codable {
  let baseCode: String
  let rates: [String: Double]
  
  enum CodingKeys: String, CodingKey {
    case baseCode = "base_code"
    case rates
  }
}
