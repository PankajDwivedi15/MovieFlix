//
//  NowPlayingViewModel.swift
//  MovieFlix
//
//  Created by MacHD on 14/05/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import Foundation

protocol NowPlayingViewModelDelegate: class {
    func getSuccessResponse(countTotal: Int, page:Int, movieList:[MovieModelClass]);
    func getFailureResponse(message:String);
}


class NowPlayingViewModel {
    
    weak var delegate:NowPlayingViewModelDelegate?
    
    func getTheMovieList(pageNumber:Int) {
        let page = "\(pageNumber)"
        
        NetworkingClient().request(urlString: ServiceCall.Now_Playing.rawValue + Constant.API_KEY + Constant.Page_Number + page, httpMethod: .get, parameters: MovieRequest.init(key:Constant.API_KEY, page:page), decodingType: MovieNowPlayingResponse.self, isGet:true) { (response, msg) in
                                                        
            if (response == nil) {
                self.delegate?.getFailureResponse(message: msg ?? "")
            }
            else if ((response as! MovieNowPlayingResponse).page > 0){
                print("Success Response: \(String(describing: response))")
                let movieList = MovieModelClass.setValueForClass(response: response as! MovieNowPlayingResponse)
                self.delegate?.getSuccessResponse(countTotal: (response as! MovieNowPlayingResponse).totalPages, page: pageNumber, movieList: movieList)
            }
            else {
                self.delegate?.getFailureResponse(message: msg ?? "")
            }
                
            
        }
    }
}
