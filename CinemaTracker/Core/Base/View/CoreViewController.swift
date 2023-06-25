//
//  CoreViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.06.2023.
//

import UIKit



class CoreViewController<T:CoreViewModel> : UIViewController {
    
    lazy var viewModel : T = T()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindObservable()
        viewModel.onInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTheme()
    }
    
    func setUpView() {
        
    }
    
    func initTheme() {
        
    }
    
    func bindObservable() {
        
    }
    
}
