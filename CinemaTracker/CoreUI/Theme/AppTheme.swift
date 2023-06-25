//
//  AppTheme.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 14.06.2023.
//

import Foundation

enum ThemeType {
    case Light
    case Dark
}

protocol Theme {
    var colors: ThemeColor {get set}
    
    func changeTheme(type:ThemeType)
}



final class AppTheme : Theme {
    static let shared = AppTheme()
    
    
    private let lightColor = AppLightColor()
    private let darkColor = AppDarkColor()
    
    var currentTheme = ThemeType.Light
    
    private init() {}
    
    var colors: ThemeColor = AppLightColor()
    
    func changeTheme(type: ThemeType) {
        switch(type) {
        case .Light:
            self.colors = lightColor
            self.currentTheme = .Light
        case .Dark:
            self.colors = darkColor
            self.currentTheme = .Dark
        }
    }
}


