//
//  HomeViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 12.06.2023.
//

import UIKit

final class HomeViewController: CoreViewController <HomeViewModel> {

    override func setUpView() {
        view.backgroundColor = AppTheme.shared.colors.secondaryGray
    }
    
    override func initTheme() {
        
    }
    
    override func bindObservable() {
        
    }
    
}


