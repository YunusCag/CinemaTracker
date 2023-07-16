//
//  LocalizableExtension.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 8.07.2023.
//

import Foundation


extension RawRepresentable where Self.RawValue == String  {
    func getLocalized() -> String {
        return self.rawValue.localized()
    }
}

extension String {
    
    func localized() -> String {
        let languageCode = LanguageTypeManager.shared.languageType.rawValue
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let bundle = Bundle(path: bundlePath) else {
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: bundle,
            comment: self
        )
    }
}


extension Bundle {
    @objc private func myLocaLizedString(forKey key: String,value: String?, table: String?) -> String {
        let languageCode = LanguageTypeManager.shared.languageType.rawValue
        
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: bundlePath) else {
            return Bundle.main.myLocaLizedString(forKey: key, value: value, table: table)
        }
        return bundle.myLocaLizedString(forKey: key, value: value, table: table)
    }
}
