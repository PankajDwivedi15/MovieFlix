//
//  TopRatedViewModel.swift
//  MovieFlix
//
//  Created by MacHD on 15/05/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import Foundation

protocol TopRatedViewModelDelegate: class {
    func getSuccessResponse(countTotal: Int, page:Int, movieList:[MovieModelClass]);
    func getFailureResponse(message:String);
}


class TopRatedViewModel {
    
    weak var delegate:TopRatedViewModelDelegate?
    
    func getTheMovieList(pageNumber:Int) {
        let page = "\(pageNumber)"
        
        NetworkingClient().request(urlString: ServiceCall.Top_Rated.rawValue + Constant.API_KEY + Constant.Page_Number + page, httpMethod: .get, parameters: MovieRequest.init(key:Constant.API_KEY, page:page), decodingType: MovieTopRatedResponse.self, isGet:true) { (response, msg) in
                                                        
            if (response == nil) {
                self.delegate?.getFailureResponse(message: msg ?? "")
            }
            else if ((response as! MovieTopRatedResponse).page > 0){
                print("Success Response: \(String(describing: response))")
                let movieList = MovieModelClass.setValueForClass(response: response as! MovieTopRatedResponse)
                self.delegate?.getSuccessResponse(countTotal: (response as! MovieTopRatedResponse).totalPages, page: pageNumber, movieList: movieList)
            }
            else {
                self.delegate?.getFailureResponse(message: msg ?? "")
            }
                
            
        }
    }
}
