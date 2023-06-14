//
//  ThemeProtocol.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 14.06.2023.
//

import Foundation
import UIKit

protocol ThemeColor{
    var primary: UIColor {get}
    var secondary: UIColor {get}
    var accent: UIColor {get}
    var whiteColor: UIColor {get}
    var blackColor: UIColor {get}
    var background: UIColor {get}
    var textPrimary: UIColor {get}
    var secondaryGray: UIColor {get}
    var card: UIColor {get}
    var dividerColor: UIColor {get}
    var barStyle: UIBarStyle {get}

}
