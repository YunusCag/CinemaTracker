//
//  MovieListViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit


final class MovieListViewControler: CoreViewController <MovieListViewModel> {
    
    var listTitle: String? = nil
    override func setUpView() {
        self.title = listTitle ?? Constant.StringParameter.EMPTY_STRING
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
    }
    
    override func bindObservable() {
        
    }
    
}
