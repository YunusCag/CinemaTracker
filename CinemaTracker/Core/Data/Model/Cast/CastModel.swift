//
//  CastModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 20.07.2023.
//

import Foundation

struct CastModel: Codable {
    var adult: Bool? = nil
    var gender: Int? = nil
    var id: Int? = nil
    var knownForDepartment: String? = nil
    var name: String? = nil
    var originalName: String? = nil
    var popularity: Double? = nil
    var profilePath: String? = nil
    var castId: Int? = nil
    var character: String? = nil
    var creditId: String? = nil
    var order: Int? = nil
    
    private enum CodingKeys : String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character = "character"
        case creditId = "credit_id"
        case order = "order"
    }
}
