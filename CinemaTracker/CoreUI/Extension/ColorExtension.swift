//
//  ColorExtension.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 14.06.2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        let iBlue = rgb & 0xFF
        let iGreen =  (rgb >> 8) & 0xFF
        let iRed =  (rgb >> 16) & 0xFF
        let iAlpha =  (rgb >> 24) & 0xFF
        self.init(red: CGFloat(iRed)/255, green: CGFloat(iGreen)/255,
                  blue: CGFloat(iBlue)/255, alpha: CGFloat(iAlpha)/255)
    }
}
