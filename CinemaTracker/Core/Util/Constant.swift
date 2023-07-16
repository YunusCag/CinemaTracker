//
//  Constant.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation



struct Constant{
    struct StringParameter {
        static let EMPTY_STRING = ""
    }
    struct DurationUtil {
        static let HOME_AUTO_SCROLL_DURATION = 5.0
    }
    
    struct NetworkParamKey {
        static let page: String = "page"
        static let language = "language"
        static let region = "region"
        static let withGenres = "with_genres"
        static let movieId = "movie_id"
        static let apiKey = "api_key"
    }
    
    struct NotificationCenterUtil {
        static let SETTING_CHANGE_KEY = "setting_change_key"
    }
    
}
