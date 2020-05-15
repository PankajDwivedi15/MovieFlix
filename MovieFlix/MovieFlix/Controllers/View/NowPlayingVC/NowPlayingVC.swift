//
//  NowPlayingVC.swift
//  MovieFlix
//
//  Created by MacHD on 14/05/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import UIKit

class NowPlayingVC: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblNowPlaying: UITableView!
    
    private var movieArr = [MovieModelClass]()
    private var movieFilterArr = [MovieModelClass]()
    private var pageNumber:Int = 0
    var totalPages:Int = 1
    
    private let modelView = NowPlayingViewModel()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // ---- Add the modelview delegate ------- //
        modelView.delegate = self
        
        // ------- Add Refresh Controller ----- //
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblNowPlaying.addSubview(refreshControl)
        refreshControl.endRefreshing()
        
        // ------ Add Border color to search field ------ //
        searchBar.searchBarStyle = .prominent
        searchBar.isTranslucent = false
        let textFieldInside = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInside?.backgroundColor = UIColor.white
        searchBar.barTintColor = Constant.YelloW_Color
        
        // ------- Calling for service details ------ //
        getTheMovieList(page: pageNumber + 1)
    }
    
    func getTheMovieList(page:Int) {
        
        if !Manager.shared.isNetworkConnected(self) {
            Manager.shared.showAlert(self, message: Constant.ALERT_NO_INTERNET)
        }
        else {
            modelView.getTheMovieList(pageNumber: page)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getTheMovieList(page: pageNumber + 1)
    }
}

extension NowPlayingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieFilterArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.NowPlayingCell.rawValue) as! MovieTableCell
        cell.setUpCell(detail: movieFilterArr[indexPath.row])
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = self.storyboard?.instantiateViewController(identifier: "DetailVC")as! DetailVC
        detail.detailSelected = movieFilterArr[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
            
            let alert = UIAlertController.init(title:Constant.ALERT_TITLE, message: "Do you want to delete this movie?", preferredStyle: .alert)
            let alertYes = UIAlertAction.init(title: "Yes", style: .default) { (response) in
                self.movieFilterArr.remove(at: indexPath.row)
                self.tblNowPlaying.beginUpdates()
                self.tblNowPlaying.deleteRows(at: [indexPath], with: .automatic)
                self.tblNowPlaying.endUpdates()
            }
            let alertNo = UIAlertAction.init(title: "No", style: .default) { (response) in
            }
            alert.addAction(alertYes)
            alert.addAction(alertNo)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

extension NowPlayingVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if search.count > 0 {
            let arr = movieArr.filter{ $0.originalTitle.contains(search) }
            if arr.count > 0 {
                movieFilterArr = arr
            }
            else {
                movieFilterArr = movieArr
            }
            tblNowPlaying.reloadData()
        }
        else {
            movieFilterArr = movieArr
            tblNowPlaying.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieFilterArr = movieArr
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        tblNowPlaying.reloadData()
    }
    
}

extension NowPlayingVC: NowPlayingViewModelDelegate {
    func getSuccessResponse(countTotal: Int, page:Int, movieList:[MovieModelClass]){
        pageNumber = page
        
        totalPages = countTotal
        for item in movieList {
            movieArr.append(item)
        }
        movieFilterArr = movieArr
        refreshControl.endRefreshing()
        tblNowPlaying.reloadData()
    }
    
    func getFailureResponse(message:String) {
        refreshControl.endRefreshing()
        Manager.shared.showAlert(self, message: message)
    }
}
