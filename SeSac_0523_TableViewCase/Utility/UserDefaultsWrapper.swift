//
//  UserDefaultsWrapper.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/23/24.
//

import SwiftUI

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    var wrappedValue: T {
        get {
            print(#function)
            guard let data = UserDefaults.standard.data(forKey: key) else {
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
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print(
                    String(describing: T.self),
                    "인코딩 에러: \(error.localizedDescription)"
                )
            }
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
