//
//  HeaderTableViewCell.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 13/02/2022.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var dogBreedName: UILabel!
    @IBOutlet private weak var dogSubBreeds: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var isFavoriteActionHandler:((_ isFavorite: Bool) -> Void)?

    
    var dogBreed: DogBreed? = nil {
        didSet {
            dogBreedName.text = dogBreed?.name
            
            if let subBreeds = dogBreed?.subBreeds, subBreeds.isEmpty == false {
                let formattedArray = (subBreeds.map{String($0)}).joined(separator: ", ")

                dogSubBreeds.text = formattedArray
            } else {
                dogSubBreeds.text = "No Sub-breeds found"
            }
        }
    }
    
    var isfavorite: Bool = false {
        didSet {
            if isfavorite {
                favoriteButton.setTitle("Unfavorite", for: .normal)
            } else {
                favoriteButton.setTitle("Favorite", for: .normal)
            }
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if let isFavoriteActionHandler = isFavoriteActionHandler {
            isFavoriteActionHandler(!isfavorite)
        }
        self.isfavorite = !isfavorite
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
