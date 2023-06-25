//
//  TitleLabel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import Foundation
import UIKit

class AppLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initStyle(typograph: Typography,color: UIColor = AppTheme.shared.colors.textPrimary) {
        switch(typograph){
        case .title:
            self.font = .systemFont(ofSize: 20,weight: .bold)
        case .subtitle:
            self.font = .systemFont(ofSize: 18,weight: .semibold)
        case .normal1:
            self.font = .systemFont(ofSize: 16,weight: .semibold)
        case .normal2:
            self.font = .systemFont(ofSize: 14,weight: .medium)
        case .small1:
            self.font = .systemFont(ofSize: 12,weight: .medium)
        case .small2:
            self.font = .systemFont(ofSize: 10,weight: .regular)
        }
        self.textColor = color
    }
    
}
