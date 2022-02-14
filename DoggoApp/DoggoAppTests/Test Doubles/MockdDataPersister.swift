//
//  MockdDataPersister.swift
//  DoggoAppTests
//
//  Created by Faisal Rahman on 13/02/2022.
//

import Foundation
@testable import DoggoApp

class MockdDataPersister: DataPersister {
    
    var isCalled = false
    
    private var data: [String : [String]] = [:]
    
    func setPersistingData(key: String, value: [String]) {
        data = [key : value]
    }
    
    func getPersistingData(key: String) -> [String] {
        self.isCalled = true
        return data[key] ?? []
    }
}
