//
//  MovieTableViewCell.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-13.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MovieName: UILabel!
    
    @IBOutlet weak var ReleaseYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
