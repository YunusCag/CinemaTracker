//
//  CoreViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.06.2023.
//

import Foundation
import UIKit



class CoreViewController<T:CoreViewModel> : UIViewController {
    
    lazy var viewModel : T = T()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initTheme()
        bindObservable()
        viewModel.onInit()
    }
    
    func setUpView() {
        
    }
    
    func initTheme() {
        
    }
    
    func bindObservable() {
        
    }
}
