//
//  BreedListViewController.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import UIKit

class BreedListViewController: UIViewController, DogBreedView {
    
    var viewTitle: String = "" {
        didSet {
            self.title = viewTitle
        }
    }
    
    var dogBreeds: [DogBreed] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: DogBreedListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BreedListTableViewCell", bundle: nil), forCellReuseIdentifier: "BreedListTableViewCell")
        
        presenter?.viewLoaded()
    }
    

}

extension BreedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BreedListTableViewCell", for: indexPath) as? BreedListTableViewCell {
            cell.dogBreed = dogBreeds[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension BreedListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBreed = dogBreeds[indexPath.row]
        presenter?.selectedDogBreed(breed: selectedBreed)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
}
