# 📱 프로젝트 소개
환율 정보를 조회하고, 즐겨찾기 기능과 계산기 기능을 제공하는 iOS 앱입니다.

<br>

# 프로젝트 기간
* 2025.07.07(월)~2025.07.13(일)

<br>

# 시연
<p align="center">
  <img src="https://github.com/user-attachments/assets/e0a5418f-35c5-412b-8409-9600b5c65b5e" width="45%" />
  <img src="https://github.com/user-attachments/assets/e2ab7f0c-14aa-4c65-aa07-9ef38097699c" width="45%" />
</p>
<p align="center">
  <sub>iPhone 16 Pro Max</sub>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <sub>iPhone SE (2nd Gen)</sub>
</p>

<br>

# 🔧 주요 기능

* 실시간 환율 목록 조회 (Open Exchange Rate API 기반)
* 통화 코드 및 국가명 검색 기능
* 즐겨찾기(★) 등록 및 목록 상단 고정 기능 (CoreData 기반)
* 환율 계산기 기능 (입력값 기반 계산, 소수점 2자리 표시)
* 사용자 입력 오류에 대한 예외처리 Alert 제공
* 다크모드 대응 (system color 활용)
* MVVM 아키텍처 기반 View-ViewModel 분리 및 상태 전달 처리
* 다양한 기기 크기에 대응 (iPhone SE ~ iPhone 16 Pro Max 대응 완료)

<br>

# 📂 폴더 구조

```
HwanYulApp/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── CoreData/
│       ├── CoreDataManager.swift
│       ├── CurrencyDataModel.xcdatamodeld
│       ├── FavoriteCurrency+CoreDataClass.swift
│       └── FavoriteCurrency+CoreDataProperties.swift
├── Model/
│   ├── Currency.swift
│   ├── CurrencyCountryMap.swift
│   └── CurrencyItem.swift
├── ViewModel/
│   ├── CurrencyCalculatorViewModel.swift
│   ├── CurrencyListViewModel.swift
│   └── ViewModelProtocol.swift
├── View/
│   ├── CurrencyCalculatorViewController.swift
│   ├── CurrencyListCell.swift
│   └── CurrencyListViewController.swift
├── Utils/
│   ├── AlertFactory.swift
│   └── DataService.swift
├── Resources/
│   ├── Assets.xcassets
│   ├── Info.plist
│   └── LaunchScreen.storyboard
```

<br>

# 🛠 사용 기술
* Swift
* UIKit + SnapKit
* MVVM 아키텍처 (View / ViewModel / Model 구성)
* Open Exchange Rate API
