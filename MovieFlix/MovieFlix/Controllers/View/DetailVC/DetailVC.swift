//
//  DetailVC.swift
//  MovieFlix
//
//  Created by MacHD on 14/05/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var viewDisplay: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    var detailSelected:MovieModelClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpView()
    }
    
    func setUpView() {
        movieImage.kf.setImage(with: URL(string: detailSelected?.backdropPath ?? ""))
        lblTitle.text = detailSelected?.title
        lblMovieDescription.text = detailSelected?.overview
        lblMovieDuration.text = setTheDuaration(gotDate: detailSelected?.releaseDate ?? "")
        lblMovieDate.text = setTheDate(gotDate: detailSelected?.releaseDate ?? "")
        
        if let percentage = detailSelected?.voteAverage {
            lblPercentage.text = "\(percentage)".setPercentage()
        }
        else {
            lblPercentage.text = "0 %"
        }
        
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTheDuaration(gotDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"  // 2020-02-19
        let date = dateFormatter.date(from: gotDate)
        
        dateFormatter.dateFormat = "hh"
        let hour = dateFormatter.string(from: date!)
        
        dateFormatter.dateFormat = "mm"
        let minute = dateFormatter.string(from: date!)
        
        let time = hour + " hrs " + minute + " min"
        
        
        return time
    }
    
    func setTheDate(gotDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"  // 2020-02-19
        let date = dateFormatter.date(from: gotDate)
        
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        let movieDate = dateFormatter.string(from: date!)
        
        return movieDate
    }
}
