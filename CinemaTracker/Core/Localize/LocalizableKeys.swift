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
        case noConnection = "common_no_connection"
        case errorText = "common_eror_text"
        case errorButton = "common_eror_button"
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
        case emptyListTitle = "favourite_empty_list_title"
    }
    
    enum Settings: String {
        case tabItem = "settings_tab_item_text"
        case languageChoice = "settings_language_choice"
        case regionChoice = "settings_region_choice"
        case themeChoice = "settings_theme_choice"
    }
    
    enum MovieDetail: String {
        case country = "movie_detail_country"
        case genre = "movie_detail_genre"
        case budget = "movie_detail_budget"
        case currency = "movie_detail_currency"
        case revenue = "movie_detail_revenue"
        case releaseDate = "movie_detail_release_date"
        case cast = "movie_detail_cast"
        case crew = "movie_detail_crew"
        case trailer = "movie_detail_trailer"
    }
}
