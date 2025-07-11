//
//  ViewModelProtocol.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/10/25.
//

protocol ViewModelProtocol {
  associatedtype Action // 사용자가 발생시키는 이벤트
  associatedtype State // 화면 상태
  
  var state: State { get } // 읽기 (가져오지만 변경 불가)
  func action(_ action: Action) 
}
