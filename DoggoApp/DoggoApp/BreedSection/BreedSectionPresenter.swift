//
//  BreedSectionPresenter.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import Foundation

class BreedSectionPresenter {
    
    weak private var view: BreedSectionView?
    weak private var routingDelegate: BreedSectionRoutingDelegate?
    private var dogInformationService: DogInformationService?
    private var selectedDogBreed: DogBreed
    private var dataPersister: DataPersister?
    let title = "Dog Breed"

    init(view: BreedSectionView, dogInformationService: DogInformationService, selectedDogBreed: DogBreed, routingDelegate: BreedSectionRoutingDelegate, dataPersister: DataPersister) {
        self.view = view
        self.routingDelegate = routingDelegate
        self.dogInformationService = dogInformationService
        self.selectedDogBreed = selectedDogBreed
        self.dataPersister = dataPersister
    }

    func viewLoaded() {
        setTitle()
        setBreedInfo()
        getDogBreedImages()
        setIsFavorite()
    }
    
    func setIsFavorite() {
        var breeds = dataPersister?.getPersistingData(key: favoriteBreedsKey) ?? []
        view?.isFavorite = breeds.contains(selectedDogBreed.name)
    }
    
    func setBreedInfo() {
        view?.dogBreed = selectedDogBreed
    }
    
    func setTitle() {
        view?.viewTitle = selectedDogBreed.name
    }

    func makeCurrentBreedFavorite(isFavorite: Bool) {
        var breeds = dataPersister?.getPersistingData(key: favoriteBreedsKey) ?? []
        
        if isFavorite {
            breeds.append(selectedDogBreed.name)
        } else {
            if let index = breeds.firstIndex(of: selectedDogBreed.name) {
                breeds.remove(at: index)
            }
        }
        
        dataPersister?.setPersistingData(key: favoriteBreedsKey, value: breeds)
    }
    
    func getDogBreedImages() {
        dogInformationService?.multipleImagesByBreed(breedName: selectedDogBreed.name, dogBreedImageUrls: { [weak self] imageURLs in
            guard let self = self else { return }
            self.view?.dogImages = imageURLs
        })
    }
    
}

protocol BreedSectionRoutingDelegate: AnyObject {

}

protocol BreedSectionView: AnyObject {
    var dogBreed: DogBreed? { get set }
    var dogImages: [URL]? { get set }
    var viewTitle: String {get set}
    var isFavorite: Bool? {get set}
    
    
}
