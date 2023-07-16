//
//  LocalizableKeys.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 8.07.2023.
//

import Foundation


enum LocalizableKeys : String{
    
    case turkish = "Turkish"
    case english = "English"
    
    enum Common: String {
        case languageTurkish = "common_turkish"
        case languageEnglish = "common_english"
        case regionTurkey = "common_turkey"
        case regionUSA = "common_usa"
        case all = "common_all"
        case darkTheme = "common_dark_theme"
        case lightTheme = "common_light_theme"
    }
    
    enum Home: String {
        case tabItem = "home_tab_item_text"
        case upComingTitle = "home_up_coming_title"
        case trendingTitle = "home_trending_title"
        case popularTitle = "home_popular_title"
        case topRatedTitle = "home_top_rated_title"
    }
    
    enum Favourites: String {
        case tabItem = "favourite_tab_item_text"
    }
    
    enum Settings: String {
        case tabItem = "settings_tab_item_text"
        case languageChoice = "settings_language_choice"
        case regionChoice = "settings_region_choice"
        case themeChoice = "settings_theme_choice"
    }
}
