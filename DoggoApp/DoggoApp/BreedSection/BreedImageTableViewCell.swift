//
//  BreedImageTableViewCell.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 13/02/2022.
//

import UIKit

class BreedImageTableViewCell: UITableViewCell {

    @IBOutlet private weak var dogImage: UIImageView!
    var imageURL: URL? = nil {
        didSet {
            if let url = imageURL {
                dogImage.downloaded(from: url)
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
