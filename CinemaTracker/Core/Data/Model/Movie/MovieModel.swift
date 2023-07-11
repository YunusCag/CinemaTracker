//
//  MovieModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation


struct MovieModel: Codable {
    var adult:Bool? = nil
    var backdropPath: String? = nil
    var genreIds: [Int]? = nil
    var id: Int? = nil
    var originalLanguage: String? = nil
    var originalTitle: String? = nil
    var overview: String? = nil
    var popularity: Double? = nil
    var posterPath: String? = nil
    var releaseDate: String? = nil
    var title: String? = nil
    var video: Bool? = nil
    var voteAverage: Double? = nil
    var voteCount: Int? = nil
    
    //staggered height
    let height:CGFloat = CGFloat.random(in: 200...300)
    
    private enum CodingKeys : String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
