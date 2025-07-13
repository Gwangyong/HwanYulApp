//
//  CoreDataManager.swift
//  HwanYulApp
//
//  Created by 서광용 on 7/13/25.
//

import UIKit
import CoreData

final class CoreDataManager {
  // Singleton
  static let shared = CoreDataManager() // 앱 전역에서 사용 가능. CoreDataManager.shared
  private init() {} // 외부에서 새로운 인스턴스 생성 못하도록
  
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
  
  // MARK: - 즐겨찾기 삭제
  func removeFavorite(code: String) {
    // CoreData에서 데이터 조회하기 위해 fetchRequest(요청서)가 필요
    let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
    request.predicate = NSPredicate(format: "code == %@", code) // request중에 code가 동일한 것만 찾음(predicate: 조건문)
    
    do {
      let results = try context.fetch(request) // request를 context에 전달해서 데이터 조회
      results.forEach { context.delete($0) } // 혹시 중복이 있을 수 있기에 반복해서 전체 삭제
      saveContext()
    } catch {
      print("삭제 실패: \(error)")
    }
  }
  
  // MARK: - Context 저장
  private func saveContext() {
    if context.hasChanges { // hasChanges: 저장되지 않은 변경사항이 있는지 확인하는 Bool값
      do {
        // 변경된 내용 저장
        try context.save()
      } catch {
        print("저장 실패: \(error)")
      }
    }
  }
}

/*
 
 공부하며 정리!
 
 - CoreData 저장소: 하드디스크에 있는 엑셀 파일
 - context: 지금 열어놓은 엑셀 창 (작업 중)
 - fetchRequest + predicate: 고객 이름이 "%@"인 행만 보여줘. 라고 predicate(필터)한 것
 - delete(): 엑셀 행을 지움 (현재 엑셀 창. context에서는 지워짐)
 - saveContext(): 엑셀 저장(CMD + S) 누른 것. 실제 하드디스크(CoreData)에 반영
 
 만일, saveContext()를 안하면, delete()에서 지워진 것 처럼 보이더라도, 현재 저장안된 엑셀 파일에서만 지워진 상태
 즉, 프로그램을 재시작하며 load하면 CoreData에서는 안지워져서 다지 데이터가 나타남
 
 */
