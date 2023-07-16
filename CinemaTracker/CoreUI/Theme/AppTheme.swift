//
//  AppTheme.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 14.06.2023.
//

import Foundation
import UIKit

enum ThemeType: String {
    case Light = "light"
    case Dark = "dark"
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
    
    private init() {
        let themeCode = UserDefaults.standard.string(forKey: themeKey) ?? ThemeType.Light.rawValue
        let type = ThemeType(rawValue: themeCode) ?? .Light
        self.changeTheme(type: type)
        
    }
    
    var colors: ThemeColor = AppLightColor()
    
    func changeTheme(type: ThemeType) {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        
        switch(type) {
        case .Light:
            self.colors = lightColor
            self.currentTheme = .Light
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : self.colors.textPrimary
            ]
            navigationBarAppearance.backgroundColor = self.colors.background
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            keyWindow?.overrideUserInterfaceStyle = .light
        case .Dark:
            self.colors = darkColor
            self.currentTheme = .Dark
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : self.colors.textPrimary
            ]
            navigationBarAppearance.backgroundColor = self.colors.background
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            keyWindow?.overrideUserInterfaceStyle = .dark
        }
        UserDefaults.standard.set(type.rawValue, forKey: themeKey)
    }
    
    private let themeKey = "theme_key"
}


