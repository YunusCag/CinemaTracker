//
//  StringExtension.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 19.07.2023.
//

import Foundation

extension String {
    
    
    func formatDateString(
        inputFormat: String = Constant.DateFormatUtil.basicInputFormat,
        outputFormat:String = Constant.DateFormatUtil.detailFormat
    ) -> String {
        let inputDateFormat = DateFormatter()
        inputDateFormat.dateFormat = inputFormat
        
        let outputDateFormat = DateFormatter()
        outputDateFormat.dateFormat = outputFormat
        
        outputDateFormat.locale = Locale(identifier: LanguageTypeManager.shared.languageType.rawValue)
        
        guard let inputDate = inputDateFormat.date(from: self) else {
            return Constant.StringParameter.EMPTY_STRING
        }
        
        return outputDateFormat.string(from: inputDate)
    }
}
