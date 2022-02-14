//
//  DataPersister.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 13/02/2022.
//

import Foundation

protocol DataPersister: AnyObject {
    func setPersistingData(key: String, value: [String])
    func getPersistingData(key: String) -> [String]
}

class UserDefaultsDataPersister: DataPersister {
    func setPersistingData(key: String, value: [String]) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getPersistingData(key: String) -> [String] {
        let persistingArray: [String] = UserDefaults.standard.object(forKey: key) as? [String] ?? []
        return persistingArray
    }
    
}

let favoriteBreedsKey = "favoriteBreedsKey"
