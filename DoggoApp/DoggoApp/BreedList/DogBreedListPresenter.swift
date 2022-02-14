//
//  DogBreedListPresenter.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import Foundation

class DogBreedListPresenter {
    enum State {case favorites, breedList}
    weak private var view: DogBreedView?
    weak private var routingDelegate: BreedListRoutingDelegate?
    private var dogInformationService: DogInformationService?
    private var dataPersister: DataPersister?
    var state: State = .breedList

    init(view: DogBreedView, dogInformationService: DogInformationService, routingDelegate: BreedListRoutingDelegate, dataPersister: DataPersister) {
        self.view = view
        self.routingDelegate = routingDelegate
        self.dogInformationService = dogInformationService
        self.dataPersister = dataPersister
    }

    func viewLoaded() {
        switch self.state {
        case .breedList: getDogBreeds()
        case .favorites: getFavouriteDogBreeds()
        }
        
        setTitle()
    }
    
    func setTitle() {
        if state == .breedList {
            view?.viewTitle = "Dog Breeds"
        } else if state == .favorites {
            view?.viewTitle = "Favorite Dog Breeds"
        }
    }
    
    func selectedDogBreed(breed: DogBreed) {
        guard state == .breedList else { return }
        routingDelegate?.navigateToBreedSection(breed: breed)
    }
    
    func getFavouriteDogBreeds() {
        
        dogInformationService?.specificDogBreedsWithImage( dogBreeds: dataPersister?.getPersistingData(key: favoriteBreedsKey) ?? [], dogBreedsWithImage: { [weak self] dogBreeds in
            guard let self = self else { return }
            self.view?.dogBreeds = dogBreeds
        })
    }
    
    func getDogBreeds() {
        dogInformationService?.dogBreedsWithImage(dogBreedsWithImage: { [weak self] dogBreeds in
            guard let self = self else { return }
            self.view?.dogBreeds = dogBreeds
        })
    }
    
}

protocol BreedListRoutingDelegate: AnyObject {
    func navigateToBreedSection(breed: DogBreed)
}

protocol DogBreedView: AnyObject {
    var dogBreeds: [DogBreed] { get set }
    var viewTitle: String {get set}
}

struct DogBreed {
    let name: String
    let imageURL: URL?
    let subBreeds: [String]
}
