//
//  Constant.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation



struct Constant{
    struct StringParameter {
        static let EMPTY_STRING = ""
    }
    
    struct NetworkUrl {
        static let baseImageUrl = "https://image.tmdb.org/t/p/w342"
    }
    
    struct NetworkParamKey {
        static let page: String = "page"
        static let language = "language"
        static let region = "region"
        static let withGenres = "with_genres"
        static let movieId = "movie_id"
        static let apiKey = "api_key"
    }
}
