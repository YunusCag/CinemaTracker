//
//  MovieVideoModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 21.07.2023.
//

import Foundation

struct MovieVideoModel: Codable {
    
    var name: String? = nil
    var key: String? = nil
    var site: String? = nil
    var type: String? = nil
    var official: Bool? = nil
    var publishedAt: String? = nil
    var id: String? = nil
    
    private enum CodingKeys : String, CodingKey {
        case name = "name"
        case key = "key"
        case site = "site"
        case type = "type"
        case official = "official"
        case publishedAt = "published_at"
        case id = "id"
    }
}
