//
//  DogInformationServiceTests.swift
//  DoggoAppTests
//
//  Created by Faisal Rahman on 13/02/2022.
//

import XCTest
@testable import DoggoApp

class DogInformationServiceTests: XCTestCase {
    
    var dogInformationService: DogInformationService!
    var selectedBreed: DogBreed!
    var controllableNetworkClient: ControllableNetworkClient!
    var endpoints: DoggoAppEndpoints!
    
    override func setUp() {

        controllableNetworkClient = ControllableNetworkClient()
        dogInformationService = DogInformationService(fetcher: Fetcher(networkClient: controllableNetworkClient))
        endpoints = DoggoAppEndpoints()
        selectedBreed = DogBreed(name: "Corgi", imageURL: URL(string: "www.exampleURL.com"), subBreeds: ["exampleSubBreed1", "exampleSubBreed2"])
    }

    func testCorrectDogBreedsAreFetched_WhenControllableClientIsSetToSucceed() {
        controllableNetworkClient.shouldSucceedWithDogList = true
        
        let expect = expectation(description: "dog breeds")
        
        dogInformationService.dogBreeds { breeds in
            XCTAssertTrue(breeds["dog a"] != nil)
            XCTAssertTrue(breeds["dog a"] == ["sub-breed a", "sub-breed b"])
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 5)
    }
    
    func testCorrectDogImagesAreFetched_WhenControllableClientIsSetToSucceed() {
        controllableNetworkClient.shouldSucceedWithDogImage = true
        
        let expect = expectation(description: "dog breeds")
        
        dogInformationService.fetchDogImageByBreed(breedName: "dogbreed") { url in
            XCTAssertTrue( url?.absoluteString.starts(with: "https://exampleImage.com") == true)
            expect.fulfill()

        }

        wait(for: [expect], timeout: 5)

    }
}
