//
//  UserDefaultsKey.swift
//  SeSac_0523_TableViewCase
//
//  Created by gnksbm on 5/24/24.
//

import Foundation

/*
 UserDefaultsKey
 - 장점
    - 접근연산자로 쉬운 키 사용 및 오타 방지
    - 중복된 키 사용 방지
 - 단점
    - 새로운 키 사용시 항상 정의해서 사용해야함
 */
enum UserDefaultsKey: String {
    case shoppingList, todoList, listKind
}
