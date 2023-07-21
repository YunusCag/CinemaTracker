//
//  MovieServicePath.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation


enum MovieServicePath: String {
    case UPCOMING_MOVIES_URL = "movie/upcoming"
    case POPULAR_MOVIES_URL = "movie/popular"
    case TRENDING_MOVIES_URL = "trending/movie/day"
    case TOP_RATED_MOVIES_URL = "movie/top_rated"
    case GENRE_LIST_MOVIES_URL = "genre/movie/list"
}




extension MovieServicePath {
    static func getMovieDetailUrl(movieId:Int) -> String {
        return "movie/\(movieId)"
    }
    
    static func getCreditPath(movieId:Int) -> String {
        return "movie/\(movieId)/credits"
    }
    
    static func getMovieVideoPath(movieId:Int) -> String {
        return "movie/\(movieId)/videos"
    }
}
