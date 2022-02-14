//
//  BreedListPresenterTests.swift
//  DoggoAppTests
//
//  Created by Faisal Rahman on 13/02/2022.
//
import XCTest
@testable import DoggoApp

class BreedListPresenterTests: XCTestCase {
    
    var presenter: DogBreedListPresenter!
    var mockView: MockBreedListView!
    var mockRouting: MockBreedListRouting!
    var dogInformationService: DogInformationService!
    var mockDataPersister: MockdDataPersister!
    var controllableNetworkClient: ControllableNetworkClient!
    var endpoints: DoggoAppEndpoints!
    
    override func setUp() {
        mockView = MockBreedListView()
        mockRouting = MockBreedListRouting()
        controllableNetworkClient = ControllableNetworkClient()
        dogInformationService = DogInformationService(fetcher: Fetcher(networkClient: controllableNetworkClient))
        mockDataPersister = MockdDataPersister()
        endpoints = DoggoAppEndpoints()
        presenter = DogBreedListPresenter(view: mockView, dogInformationService: dogInformationService, routingDelegate: mockRouting, dataPersister: mockDataPersister)
    }
    
    func testViewGetsTitleSet_whenViewIsLoaded() {
        givenStateIsBreedList()

        whenViewLoads()
        
        XCTAssertEqual( mockView.viewTitle, "Dog Breeds")
    }
    
    func testViewGetsTitleSet_whenViewIsLoadedWithFavoritesState() {
        givenStateIsBreedFavorites()

        whenViewLoads()

        XCTAssertEqual( mockView.viewTitle, "Favorite Dog Breeds")
    }
    
    func testControllableNetowrkHitsDogBreedsEndpoint_whenViewIsLoadedInDogBreedsState() {
        givenStateIsBreedList()
        andNetworkIsSetToSucceed()

        whenViewLoads()
        
        XCTAssertTrue( controllableNetworkClient.visitedURL?.absoluteString.starts(with: "https://dog.ceo/api/breeds") == true)
    }
    
    func testPersisterIsCalled_whenViewIsLoadedInFavoritesState() {
        givenStateIsBreedFavorites()
        andTheUserHasFavoritesInPresistence()

        whenViewLoads()
        
        XCTAssertTrue( mockDataPersister.isCalled == true)
    }
    
    func testUserIsNaivgated_whenViewAsksToNavigateToBreedSection() {
        givenStateIsBreedList()
        andViewLoads()
        
        let breed = DogBreed(name: "dog a", imageURL: URL(string: "example.com"), subBreeds: ["sub-breed a"])
        presenter.selectedDogBreed(breed: breed)
        
        XCTAssertTrue( mockRouting.userIsNavigated == true)
        XCTAssertTrue( mockRouting.dogBreedOnNavigating?.name == breed.name)
        XCTAssertTrue( mockRouting.dogBreedOnNavigating?.imageURL == breed.imageURL)
        XCTAssertTrue( mockRouting.dogBreedOnNavigating?.subBreeds == breed.subBreeds)

    }
    
    //MARK: GIVEN

    func givenViewIsLoaded() {
        presenter.viewLoaded()
    }
    
    func andViewLoads() {
        givenViewIsLoaded()
    }
    
    func andNetworkIsSetToSucceed() {
        controllableNetworkClient.shouldSucceedWithDogList = true
    }
    
    func givenStateIsBreedList() {
        presenter.state = .breedList
    }
    
    func givenStateIsBreedFavorites() {
        presenter.state = .favorites
    }
    
    func andTheUserHasFavoritesInPresistence() {
        mockDataPersister.setPersistingData(key: favoriteBreedsKey, value: ["breed a"])
    }

    func andThereAreNoFavoritedBreeds() {
        mockDataPersister.setPersistingData(key: favoriteBreedsKey, value: [])
    }

    //MARK: WHEN

    func whenViewLoads() {
        givenViewIsLoaded()
    }

    //MARK: THEN

}


class MockBreedListView: DogBreedView {
    var dogBreeds: [DogBreed] = []
    
    var viewTitle: String = ""
}

class MockBreedListRouting: BreedListRoutingDelegate {
    
    var userIsNavigated = false
    var dogBreedOnNavigating: DogBreed? = nil
    
    func navigateToBreedSection(breed: DogBreed) {
        self.userIsNavigated = true
        self.dogBreedOnNavigating = breed
    }
    
}




