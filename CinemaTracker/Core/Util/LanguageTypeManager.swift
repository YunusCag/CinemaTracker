//
//  LanguageManager.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.07.2023.
//

import Foundation


protocol LanguageProtocol {
    var languageType: LanguageType { get set }
    
    func changeLanguage(type:LanguageType)
}


class LanguageTypeManager: LanguageProtocol {
    
    static let shared: LanguageTypeManager = LanguageTypeManager()
    
    var languageType: LanguageType = .english
    
    private init() {
        let deviceLangCode = Locale.current.language.languageCode?.identifier
        let defaultCode = UserDefaults.standard.string(forKey: languageKey)
        
        if defaultCode != nil {
            self.languageType = LanguageType(rawValue: defaultCode!) ?? .english
            return
        }
        
        if deviceLangCode != nil {
            self.languageType = LanguageType(rawValue: deviceLangCode!) ?? .english
            return
        }
        
        
    }
    
    
    func changeLanguage(type:LanguageType) {
        self.languageType = type
        UserDefaults.standard.set(type.rawValue, forKey: languageKey)
    }
    
    private let languageKey = "language_key"
}
