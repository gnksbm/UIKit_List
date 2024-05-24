//
//  UserDefaultsWrapper.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import SwiftUI

/* 
 UserDefaultsManager
 - 장점
    - 여러곳에서 같은 값을 사용한다면 정적 변수로 쉽게 접근 가능해 보일러 플레이트를 줄일 수 있음
 - 우려되는 부분
    - 정적 변수를 외부로 공개해서 사용하기에 internal 이상의 접근제어자 사용
      인스턴스는 타입보다 개방된 수준을 가지지 못하기에 propertyWrapper를 숨기지 못함
      다른 개발자가 외부에서 래퍼를 직접 호출하는 형태로 사용 가능 - 사용 패턴 불일치
 */
final class UserDefaultsManager {
    @UserDefaultsWrapper(key: .shoppingList, defaultValue: [])
    static var shoppingList: [ShoppingModel]
    
    private init() { }
}

/*
 UserDefaultsKey
 - 장점
    - 접근연산자로 쉬운 키 사용 및 오타 방지
    - 중복된 키 사용 방지
 - 단점
    - 새로운 키 사용시 항상 정의해서 사용해야함
 */
enum UserDefaultsKey: String {
    case shoppingList
}

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: UserDefaultsKey
    private let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key.rawValue) 
            else {
                print("저장된 데이터 없음")
                return defaultValue
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print(
                    String(describing: T.self),
                    "디코딩 에러: \(error.localizedDescription)"
                )
                return defaultValue
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key.rawValue)
            } catch {
                print(
                    String(describing: T.self),
                    "인코딩 에러: \(error.localizedDescription)"
                )
            }
        }
    }
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
