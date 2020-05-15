//
//  MovieTableCell.swift
//  MovieFlix
//
//  Created by MacHD on 14/05/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(detail: MovieModelClass) {
        
        lblMovieTitle.text = detail.originalTitle
        lblDescription.text = detail.overview
        
        imgMovie.kf.setImage(with: URL(string: detail.posterPath))
    }

}
