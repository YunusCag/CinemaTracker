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
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            comment: self
        )
    }
}
