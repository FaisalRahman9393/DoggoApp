//
//  DogInformationService.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import Foundation

class DogInformationService {
    
    private var fetcher: Fetcher
    private let doggoAppEndpoints: DoggoAppEndpoints
    
    init(fetcher: Fetcher) {
        self.fetcher = fetcher
        self.doggoAppEndpoints = DoggoAppEndpoints()
    }
    
    func multipleImagesByBreed (breedName: String, dogBreedImageUrls: @escaping ([URL]?) -> Void) {
        
        struct MultipleImagesByBreedResponse: Codable {
            let message: [URL]?
            let status: String?
        }
        
        let endpoint = String(format: doggoAppEndpoints.multipleImagesByBreed, breedName)
        
        fetcher.fetch(from: endpoint)  { (result: Result<MultipleImagesByBreedResponse, DataError>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                dogBreedImageUrls(response.message)
            }
        }
        
    }
    
    func specificDogBreedsWithImage (dogBreeds: [String], dogBreedsWithImage: @escaping ([DogBreed]) -> Void) {
        
        var fetchedBreeds: [DogBreed] = []
        let dispatchGroup = DispatchGroup()
        
        dogBreeds.forEach { breed in
            
            dispatchGroup.enter()
            
            struct SubBreedsByBreedResponse: Codable {
                let message: [String]?
                let status: String?
            }
            
            let endpoint = String(format: doggoAppEndpoints.subBreed, breed)
            
            fetcher.fetch(from: endpoint) { (result: Result<SubBreedsByBreedResponse, DataError>) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    
                    self.fetchDogImageByBreed(breedName: breed) { url in
                        fetchedBreeds.append(DogBreed(name: breed, imageURL: url, subBreeds: response.message ?? []))
                        dispatchGroup.leave()
                    }
                }
            }
            
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            dogBreedsWithImage(fetchedBreeds)
        })
    }
    
    func dogBreedsWithImage (dogBreedsWithImage: @escaping ([DogBreed]) -> Void) {
        
        var fetchedBreeds: [DogBreed] = []
        let dispatchGroup = DispatchGroup()
        
        dogBreeds(dogBreeds: {  [weak self] breeds in
            guard let self = self else { return }
            for (key, value) in breeds {
                
                dispatchGroup.enter()
                
                self.fetchDogImageByBreed(breedName: key, url: { url in
                    
                    let fetchedBreed = DogBreed(name: key, imageURL: url, subBreeds: value)
                    fetchedBreeds.append(fetchedBreed)
                    
                    dispatchGroup.leave()
                })
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                dogBreedsWithImage(fetchedBreeds)
            })
        })
    }
    
    ///Fetches a dictionary of dog breeds. Each value in the dictionary will include a breed and an array of sub-breeds if any
    internal func dogBreeds(dogBreeds: @escaping ([String:[String]]) -> Void) {
        
        struct DogBreedsResponse: Codable {
            let message: [String: [String]]
            let status: String?
        }
        
        fetcher.fetch(from: doggoAppEndpoints.dogBreeds)  { (result: Result<DogBreedsResponse, DataError>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                dogBreeds(response.message)
            }
        }
    }
    
    ///Fetches a dictionary of dog breeds. Each value in the dictionary will include a breed and an array of sub-breeds if any
    internal func fetchDogImageByBreed(breedName: String, url: @escaping (URL?) -> Void) {
        
        struct DogBreedImageResponse: Codable {
            let message: URL?
            let status: String?
        }
        
        let endpoint = String(format: doggoAppEndpoints.imageByBreed, breedName)
        
        fetcher.fetch(from: endpoint)  { (result: Result<DogBreedImageResponse, DataError>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                url(response.message)
            }
        }
    }
    
}
