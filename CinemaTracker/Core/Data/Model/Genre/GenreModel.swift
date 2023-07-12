//
//  GenreModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 11.07.2023.
//

import Foundation

struct GenreModel: Codable {
    var id: Int? = nil
    var name: String? = nil
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
