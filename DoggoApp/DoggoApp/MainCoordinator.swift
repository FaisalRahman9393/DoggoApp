//
//  MainCoordinator.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var coordinators = [Coordinator]()
    
    let dogInformationService = DogInformationService(fetcher: Fetcher(networkClient: NetworkClient()))
    let dataPersistance = UserDefaultsDataPersister()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        pushBreedList()
    }
}

//MARK: Routing from BreedList
extension MainCoordinator: BreedListRoutingDelegate {
    func navigateToBreedSection(breed: DogBreed) {
        pushBreedSection(breed: breed)
    }
}

//MARK: Routing from BreedSection
extension MainCoordinator: BreedSectionRoutingDelegate {

    
}

//MARK: Private methods
///Private Methods to be used inside of the maincooridnator
private extension MainCoordinator {
    func pushBreedList() {
        
        //TODO: move depdencies in one place
        let viewController = BreedListViewController.loadFromNib()
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(pushFavorites))
        let presenter = DogBreedListPresenter(view: viewController,
                                              dogInformationService: dogInformationService,
                                              routingDelegate: self, dataPersister: dataPersistance)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func pushBreedSection(breed: DogBreed) {
        let viewController = BreedSectionViewController.loadFromNib()
        
        let presenter = BreedSectionPresenter(view: viewController,
                                              dogInformationService: dogInformationService,
                                              selectedDogBreed: breed,
                                              routingDelegate: self,
                                              dataPersister: dataPersistance)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @objc func pushFavorites() {
        let viewController = BreedListViewController.loadFromNib()
        viewController.navigationItem.rightBarButtonItem = nil
        let presenter = DogBreedListPresenter(view: viewController,
                                              dogInformationService: dogInformationService,
                                              routingDelegate: self, dataPersister: dataPersistance)
        presenter.state = .favorites
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: true)
    }
}


