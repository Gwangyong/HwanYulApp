//
//  FavoriteCurrency+CoreDataProperties.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/13/25.
//
//

import Foundation
import CoreData


extension FavoriteCurrency {
  
  // nonobjc: obj-c 동작안하고, swift에서만 동작
  @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCurrency> {
    return NSFetchRequest<FavoriteCurrency>(entityName: "FavoriteCurrency")
  }
  
  // @NSManaged: CoreData에 관리되는 객체를 의미
  @NSManaged public var code: String?
  
}

// FavoriteCurrency 타입이 고유하게 식별될 수 있음을 의미
extension FavoriteCurrency : Identifiable {
  
}
