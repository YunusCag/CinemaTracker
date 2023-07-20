//
//  MovieDetailResponse.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 18.07.2023.
//

import Foundation


struct MovieDetailResponse: Codable {
    var adult: Bool? = nil
    var backdropPath: String? = nil
    var genres: [GenreModel]? = nil
    var homepage: String? = nil
    var imdbId: String? = nil
    var originalLanguage: String? = nil
    var originalTitle: String? = nil
    var overview: String? = nil
    var popularity: Double? = nil
    var posterPath: String? = nil
    var releaseDate: String? = nil
    var budget: Int? = nil
    var revenue: Int? = nil
    var runtime: Int? = nil
    var status: String? = nil
    var tagline: String? = nil
    var title: String? = nil
    var voteAverage: Double? = nil
    var voteCount: Int? = nil
    var productionCountries: [ProductionCountryModel]? = nil
    
    private enum CodingKeys : String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case homepage = "homepage"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case budget = "budget"
        case revenue = "revenue"
        case runtime = "runtime"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case productionCountries = "production_countries"
    }
}


struct ProductionCountryModel: Codable {
    var name:String? = nil
    
    private enum CodingKeys : String, CodingKey {
        case name = "name"
    }
    
}
