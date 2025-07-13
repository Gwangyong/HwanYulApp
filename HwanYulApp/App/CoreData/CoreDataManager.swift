//
//  CoreDataManager.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/13/25.
//

import UIKit
import CoreData

final class CoreDataManager {
  static let shared = CoreDataManager()
  private init() {} // 왜홰?
  
  /*
   
   1. CurrencyDataModel.xcdatamodeld
      ↓
   2. NSPersistentContainer 생성 (CurrencyDataModel 기반)
      ↓
   3. 저장소 로드 or 생성
      ↓
   4. context (작업 공간) 생성
      ↓
   5. context를 통해 데이터 추가/삭제/조회/저장
   
   ---
   
   CurrencyDatamodel이라는 파일을 기반으로, container라는 데이터베이스를 만듦
   
   걔를 로딩하고, 그 위에 context릘 띄운다.
   
   */
  
  lazy var persistentContainer: NSPersistentContainer = {
    // container 생성 (딱 1개만)
    let container = NSPersistentContainer(name: "CurrencyDataModel")
    // 저장소 load
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("CoreData 로드 실패: \(error)")
      }
    }
    return container
  }()
  
  // MARK: - Context 작업 공간
  // NSManagedObjectContext: CoreData의 작업 공간(열려 있느 엑셀 창)
  // CoreData에 데이터를 추가/삭제/조회/수정 때는 반드시 이 context를 통해서만 가능
  // 이 context에서 임시로 조작하다가, save()하면 실제 DB에 반영
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - 즐겨찾기 추가
  func addFavorite(code: String) {
    // 이미 있는 context에 FavoriteCurrency라는 데이터를 추가함
    let favorite = FavoriteCurrency(context: context)
    favorite.code = code
    saveContext()
  }
  
  
  // MARK: - Context 저장
  private func saveContext() {
    if context.hasChanges { // hasChanges: 저장되지 않은 변경사항이 있는지 확인하는 Bool값
      do {
        // 변경된 내용 저장
        try context.save()
      } catch {
        print("저장 실패")
      }
    }
  }
}
