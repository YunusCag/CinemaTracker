//
//  MovieListResponse.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation


struct MovieListResponse: Codable {
    var page: Int? = nil
    var results: [MovieModel]? = nil
    var totalPages: Int? = nil
    var totalResults: Int? = nil
    
    
    private enum CodingKeys : String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
