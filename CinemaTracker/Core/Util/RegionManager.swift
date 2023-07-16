//
//  RegionManager.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 13.07.2023.
//

import Foundation


protocol RegionProtocol {
    var region:RegionType { get set }
    func changeRegion(region:RegionType)
}
class RegionManager: RegionProtocol {
    static let shared:RegionManager = RegionManager()
    var region: RegionType = RegionType.USA

    private init()  {
        let regionValue = UserDefaults.standard.string(forKey: regionKey) ?? RegionType.USA.rawValue
        self.region = RegionType(rawValue: regionValue) ?? RegionType.USA
    }
        
    
    func changeRegion(region:RegionType) {
        self.region = region
        UserDefaults.standard.setValue(region.rawValue, forKey: regionKey)
    }
    
    
    private let regionKey = "region_key"
}
