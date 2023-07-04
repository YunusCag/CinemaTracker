//
//  HomeViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 12.06.2023.
//

import UIKit
import SnapKit

final class HomeViewController: CoreViewController <HomeViewModel> {

    
    private lazy var screenWidth: CGFloat = view.frame.width
    private lazy var screenHeight: CGFloat = view.frame.height
    
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    private lazy var horizontalPager: MovieHorizontalPageList = {
        let horizonal = MovieHorizontalPageList(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
        horizonal.setTitle(title: "UpComing Movie")
        return horizonal
    }()
    
    
    override func setUpView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(horizontalPager)
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
        horizontalPager.initStyle()
    }
    
    override func bindObservable() {
        viewModel.movieList.bind { movieList in
            self.horizontalPager.addAllMovie(list: movieList)
        }
    }
    
}


