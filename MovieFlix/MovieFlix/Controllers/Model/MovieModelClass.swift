//
//  MovieModelClass.swift
//  MovieFlix
//
//  Created by MacHD on 14/05/20.
//  Copyright © 2020 organisation. All rights reserved.
//

import Foundation


class MovieModelClass {
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var posterPath: String
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var originalLanguage, originalTitle: String
    var genreIDS: [Int]
    var title: String
    var voteAverage: Double
    var overview, releaseDate: String
    
    init(popularity: Double, voteCount: Int, video: Bool, posterPath: String, id: Int, adult: Bool, backdropPath: String, originalLanguage:String, originalTitle: String, genreIDS: [Int], title: String, voteAverage: Double, overview:String, releaseDate: String) {
        
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = ServiceCall.Poster_Path_BaseUrl.rawValue + posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = ServiceCall.Poster_Path_BaseUrl.rawValue + backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    // ------  Response for TOP RATED  -------------
    class func setValueForClass(response:MovieTopRatedResponse) -> [MovieModelClass] {
        guard let gotArray = response.results as? [Result] else { return [] }
        var array = [MovieModelClass]()
        
        for item in gotArray {
            let dic = MovieModelClass.init(popularity: item.popularity, voteCount: item.voteCount, video: item.video, posterPath: item.posterPath, id: item.id, adult: item.adult, backdropPath: item.backdropPath ?? "", originalLanguage: item.originalLanguage, originalTitle: item.originalTitle, genreIDS: item.genreIDS, title: item.title, voteAverage: item.voteAverage, overview: item.overview, releaseDate: item.releaseDate)
            
            array.append(dic)
        }
        
        return array
        
    }
    
    /*
     let popularity: Double
     let voteCount: Int
     let video: Bool
     let posterPath: String
     let id: Int
     let adult: Bool
     let backdropPath: String?
     let originalLanguage, originalTitle: String
     let genreIDS: [Int]
     let title: String
     let voteAverage: Double
     let overview, releaseDate: String
     */
    
    // ------  Response for NOW PLAYING  -------------
    class func setValueForClass(response:MovieNowPlayingResponse) -> [MovieModelClass] {
        guard let gotArray = response.results as? [NowPlayingResult] else { return [] }
        var array = [MovieModelClass]()
        
        for item in gotArray {
            let dic = MovieModelClass.init(popularity: item.popularity, voteCount: item.voteCount, video: item.video, posterPath: item.posterPath ?? "", id: item.id, adult: item.adult, backdropPath: item.backdropPath ?? "", originalLanguage: item.originalLanguage.rawValue, originalTitle: item.originalTitle, genreIDS: item.genreIDS, title: item.title, voteAverage: item.voteAverage, overview: item.overview, releaseDate: item.releaseDate)
            
            array.append(dic)
        }
        
        return array
        
    }
}
