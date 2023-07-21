//
//  CastCrewResponse.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 20.07.2023.
//

import Foundation

struct CastCrewResponse: Codable {
    var id: Int? = nil
    var casts: [CastModel]? = nil
    var crews: [CrewModel]? = nil
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case casts = "cast"
        case crews = "crew"
    }
}
