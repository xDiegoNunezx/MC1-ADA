//
//  Database.swift
//  MC1-ADA
//
//  Created by Alejandro Oliva Ochoa on 23/10/23.
//

import Foundation

final class Database {
    // Func to save the list
    func save<T>(array: [T], key: String) {
        UserDefaults.standard.set(array, forKey: key)
    }
    
    // Func to load the list
    func load<T>(key: String) -> [T] {
        let array = UserDefaults.standard.array(forKey: key) as? [T] ?? [T]()
        return array
    }
}
