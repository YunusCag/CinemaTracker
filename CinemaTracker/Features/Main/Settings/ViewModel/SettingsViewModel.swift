//
//  SettingViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import Foundation


final class SettingsViewModel: CoreViewModel {
    
    private let languageManager: LanguageProtocol = LanguageTypeManager.shared
    private let regionManager: RegionProtocol = RegionManager.shared
    private let appTheme: AppTheme = AppTheme.shared
    
    var selectedRegion:RegionType = RegionType.USA
    var selectedLanguage:LanguageType = LanguageType.english
    var selectedTheme:ThemeType = .Light
    
    init(){
        self.selectedRegion = regionManager.region
        self.selectedLanguage = languageManager.languageType
        self.selectedTheme = appTheme.currentTheme
    }
    
    func onInit() {
        
    }
    
    func changeRegion(region: RegionType) {
        self.selectedRegion = region
        regionManager.changeRegion(region: region)
    }
    
    func changeLanguage(language: LanguageType) {
        self.selectedLanguage = language
        languageManager.changeLanguage(type: language)
    }
    
    func changeTheme(type:ThemeType) {
        self.selectedTheme = type
        appTheme.changeTheme(type: type)
    }
}
