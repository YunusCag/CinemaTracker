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
        static let SPACE_STRING = " "
        static let VERTICAL_BAR = " | "
    }
    
    struct DateFormatUtil {
        static let basicInputFormat = "yyyy-MM-dd"
        static let detailFormat = "dd MMMM yyyy"
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
    
    struct AdmobUtil {
        static let bannerAdId = "ca-app-pub-3940256099942544/2934735716"
        static let instertialAdId = "ca-app-pub-3940256099942544/4411468910"
        
        static let interstitalShowCount = 5
    }
    
}
