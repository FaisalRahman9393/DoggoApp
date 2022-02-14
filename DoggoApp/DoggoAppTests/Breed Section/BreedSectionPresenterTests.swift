//
//  BreedSectionPresenterTests.swift
//  DoggoAppTests
//
//  Created by Faisal Rahman on 13/02/2022.
//

import XCTest
@testable import DoggoApp

class BreedSectionPresenterTests: XCTestCase {
    
    var presenter: BreedSectionPresenter!
    var mockView: MockBreedSectionView!
    var mockRouting: MockBreedSectionRouting!
    var dogInformationService: DogInformationService!
    var selectedBreed: DogBreed!
    var mockDataPersister: MockdDataPersister!
    var controllableNetworkClient: ControllableNetworkClient!
    var endpoints: DoggoAppEndpoints!
    
    override func setUp() {
        mockView = MockBreedSectionView()
        mockRouting = MockBreedSectionRouting()
        controllableNetworkClient = ControllableNetworkClient()
        dogInformationService = DogInformationService(fetcher: Fetcher(networkClient: controllableNetworkClient))
        mockDataPersister = MockdDataPersister()
        endpoints = DoggoAppEndpoints()
        selectedBreed = DogBreed(name: "Corgi", imageURL: URL(string: "www.exampleURL.com"), subBreeds: ["exampleSubBreed1", "exampleSubBreed2"])
        presenter = BreedSectionPresenter(view: mockView, dogInformationService: dogInformationService, selectedDogBreed: selectedBreed, routingDelegate: mockRouting, dataPersister: mockDataPersister)
    }
    
    func testViewGetsBreedInfo_whenViewIsLoaded() {
        givenViewIsLoaded()
        
        andBreedIsSelected()
        
        XCTAssertEqual( mockView.viewTitle, "Corgi")
        XCTAssertEqual( mockView.dogBreed?.name, "Corgi")
        XCTAssertEqual( mockView.dogBreed?.imageURL, URL(string: "www.exampleURL.com"))
        XCTAssertEqual( mockView.dogBreed?.subBreeds, ["exampleSubBreed1", "exampleSubBreed2"])
    }
    
    func testViewGetsBreedFavoriteStatus_whenViewIsLoaded() {
        
        givenBreedIsSelected()
        andBreedIsSetToBeFavorite(breedName: "Corgi")

        whenViewLoads()
        
        XCTAssertTrue( mockView.isFavorite == true)
        
    }
    
    func testViewDoesntContainFavoritedBreed_whenThereAreNoFavoritedBreeds() {
        givenBreedIsSelected()
        andThereAreNoFavoritedBreeds()
        
        whenViewLoads()
        
        XCTAssertEqual( mockView.isFavorite, false)
    }
    
    func testDogImagesAreFetched_whenViewLoads() {
        givenBreedIsSelected()
        andNetworkIsSetToSucceed()
        
        whenViewLoads()
                
        XCTAssertEqual( mockView?.dogImages?[0], URL(string: "www.exampleURL1.com"))
        XCTAssertEqual( mockView?.dogImages?[1], URL(string: "www.exampleURL2.com"))
        XCTAssertEqual( mockView?.dogImages?[2], URL(string: "www.exampleURL3.com"))
    }
    
    //MARK: GIVEN

    func givenBreedIsSelected() {
        andBreedIsSelected()
    }

    func givenViewIsLoaded() {
        presenter.viewLoaded()
    }

    func andBreedIsSelected() {
        selectedBreed = DogBreed(name: "Corgi", imageURL: URL(string: "www.exampleURL.com"), subBreeds: ["exampleSubBreed1", "exampleSubBreed2"])
    }
    
    func andBreedIsSetToBeFavorite(breedName: String) {
        mockDataPersister.setPersistingData(key: favoriteBreedsKey, value: [breedName])
    }

    func andThereAreNoFavoritedBreeds() {
        mockDataPersister.setPersistingData(key: favoriteBreedsKey, value: [])
    }
    
    func andNetworkIsSetToSucceed() {
        controllableNetworkClient.shouldSucceedWithMultipleDogImages = true
    }

    //MARK: WHEN

    func whenViewLoads() {
        givenViewIsLoaded()
    }

    //MARK: THEN

}

class MockBreedSectionView: BreedSectionView {
    var dogBreed: DogBreed? = nil
    var dogImages: [URL]? = []
    var viewTitle: String = ""
    var isFavorite: Bool? = false
}

class MockBreedSectionRouting: BreedSectionRoutingDelegate {
    
}




