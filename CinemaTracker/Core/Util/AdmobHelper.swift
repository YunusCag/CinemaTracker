//
//  AdmobHelper.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 26.07.2023.
//

import Foundation
import GoogleMobileAds

final class AdmobHelper {
    static let shared = AdmobHelper()
        
    private init() {}
    
    private var interstitalCounter = 0
    
    
    func increaseCounter() {
        self.interstitalCounter += 1
        print("Interstital Counter: \(interstitalCounter)")
    }
    
    func checkShowInterstital() -> Bool {
        return interstitalCounter % Constant.AdmobUtil.interstitalShowCount == 0
    }
}
