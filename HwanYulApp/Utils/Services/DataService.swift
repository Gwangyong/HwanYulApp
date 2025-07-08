//
//  DataService.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/8/25.
// MARK: API 요청 + Codable 파싱

import Foundation
import Alamofire

final class DataService {
  
  // MARK: - Alamofire를 사용해서 서버 데이터를 불러오는 메서드
  private func fetchDataByAlamofire<T: Decodable>(url: URL, complection: @escaping (Result<T, AFError>) -> Void) {
    AF.request(url).responseDecodable(of: T.self) { response in
      complection(response.result)
    }
  }
  
  // MARK: - 서버에서 데이터를 불러오는 메서드
  func fetchCurrencyData(completion: @escaping (Currency) -> Void) {
    // URL 생성
    let baseCode = "USD" // "KRW", "EUR"
    guard let url = URL(string: "https://open.er-api.com/v6/latest/\(baseCode)") else {
      print("잘못된 URL입니다.")
      return
    }
    
    fetchDataByAlamofire(url: url) { (result: Result<Currency, AFError>) in
      
      switch result {
      case .success(let result):
        completion(result)
      case .failure(let error):
        print("파싱 실패: \(error)")
      }
    }
  }
}

