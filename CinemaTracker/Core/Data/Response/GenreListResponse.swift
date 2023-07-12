//
//  GenreListResponse.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 11.07.2023.
//

import Foundation

struct GenreListResponse: Codable {
    var genres: [GenreModel]? = nil
    
    private enum CodingKeys : String, CodingKey {
        case genres = "genres"
    }
}
