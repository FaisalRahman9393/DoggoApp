//
//  BreedListTableViewCell.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 12/02/2022.
//

import UIKit

class BreedListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var breedImage: UIImageView!
    @IBOutlet private weak var breedName: UILabel!
    @IBOutlet private weak var numberOfSubBreeds: UILabel!
    
    var dogBreed: DogBreed? = nil {
        didSet {
            breedName.text = dogBreed?.name
            numberOfSubBreeds.text = "\(dogBreed?.subBreeds.count ?? 0 )"
            if let url = dogBreed?.imageURL {
                breedImage.downloaded(from: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
