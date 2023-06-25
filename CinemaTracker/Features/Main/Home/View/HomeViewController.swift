//
//  HomeViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 12.06.2023.
//

import UIKit
import SnapKit

final class HomeViewController: CoreViewController <HomeViewModel> {

    
    private lazy var titleLabel: AppLabel = AppLabel()
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    override func setUpView() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.text = "Home"
        titleLabel.textAlignment = .center
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
        titleLabel.initStyle(typograph: .title)
    }
    
    override func bindObservable() {
        
    }
    
}


