//
//  BreedSectionViewController.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import UIKit

class BreedSectionViewController: UIViewController, BreedSectionView {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: BreedSectionPresenter?
    var isFavorite: Bool? = false
    
    var viewTitle: String = "" {
        didSet {
            title = viewTitle
        }
    }
    
    var dogImages: [URL]? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    var dogBreed: DogBreed? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        presenter?.viewLoaded()
        
        tableView.register(UINib(nibName: "BreedImageTableViewCell", bundle: nil), forCellReuseIdentifier: "BreedImageTableViewCell")

        // Do any additional setup after loading the view.
    }

}

extension BreedSectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogImages?.count ?? 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BreedImageTableViewCell", for: indexPath) as? BreedImageTableViewCell {
            cell.imageURL = dogImages?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}

extension BreedSectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        view.dogBreed = dogBreed
        view.isfavorite = self.isFavorite ?? false
        view.isFavoriteActionHandler = { isFavorite in
            self.presenter?.makeCurrentBreedFavorite(isFavorite: isFavorite)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 73
    }
}
