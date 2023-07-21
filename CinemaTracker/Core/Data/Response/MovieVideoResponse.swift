//
//  MovieVideoResponse.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 21.07.2023.
//

import Foundation

struct MovieVideoResponse: Codable {
    var results: [MovieVideoModel]? = nil
    
    private enum CodingKeys : String, CodingKey {
        case results = "results"
    }
}
