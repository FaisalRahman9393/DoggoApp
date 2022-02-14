//
//  ControllableNetworkClient.swift
//  DoggoAppTests
//
//  Created by Faisal Rahman on 13/02/2022.
//

import Foundation
@testable import DoggoApp

class ControllableNetworkClient: NetworkClientPort {
    
    var visitedURL: URL? = nil
    
    private var dogListJSON: String = """
    {
        "message": {
            "dog a": ["sub-breed a", "sub-breed b"],
            "dog b": ["sub-breed a", "sub-breed b"],
            "dog c": ["sub-breed a", "sub-breed b"],
            "dog d": ["sub-breed a", "sub-breed b"]
        },
        "status": "success"
    }
    """
    
    private var dogImageJSON: String = """
    {
        "message": "https://exampleImage.com",
        "status": "success"
    }
    """
    
    private var dogImagesJSON: String = """
    {
        "message": ["www.exampleURL1.com","www.exampleURL2.com","www.exampleURL3.com"],
        "status": "success"
    }
    """
    
    var shouldSucceedWithDogImage = false
    
    var shouldSucceedWithMultipleDogImages = true
    
    var shouldSucceedWithDogList = false
    
    func perform(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.visitedURL = request.url!
        
        if shouldSucceedWithDogImage {
            completionHandler(Data(dogImageJSON.utf8), nil, nil)
        } else if shouldSucceedWithDogList {
            completionHandler(Data(dogListJSON.utf8), nil, nil)
        } else if shouldSucceedWithMultipleDogImages {
            completionHandler(Data(dogImagesJSON.utf8), nil, nil)

        }
        
    }
    
}
