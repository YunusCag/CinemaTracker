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
    
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    private lazy var largeHorizontalPager: MovieHorizontalPageList = {
        let horizonal = MovieHorizontalPageList(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
        horizonal.setTitle(title: LocalizableKeys.Home.upComingTitle.getLocalized())
        return horizonal
    }()
    
    private lazy var trendingHorizontalList: MovieSmallHorizontalList = {
        let horizontal = MovieSmallHorizontalList(frame: CGRect(x: 0, y: largeHorizontalPager.frame.maxY + 50, width: screenWidth, height: 200))
        horizontal.setTitle(title: LocalizableKeys.Home.trendingTitle.getLocalized())
        return horizontal
    }()
    
    private lazy var popularHorizontalList: MovieSmallHorizontalList = {
        let horizontal = MovieSmallHorizontalList(frame: CGRect(x: 0, y: trendingHorizontalList.frame.maxY + 20, width: screenWidth, height: 200))
        horizontal.setTitle(title: LocalizableKeys.Home.popularTitle.getLocalized())
        return horizontal
    }()
    
    private lazy var topRatedHorizontalList: MovieSmallHorizontalList = {
        let horizontal = MovieSmallHorizontalList(frame: CGRect(x: 0, y: popularHorizontalList.frame.maxY + 20, width: screenWidth, height: 200))
        horizontal.setTitle(title: LocalizableKeys.Home.topRatedTitle.getLocalized())
        return horizontal
    }()
    
    override func setUpView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(largeHorizontalPager)
        scrollView.addSubview(trendingHorizontalList)
        scrollView.addSubview(popularHorizontalList)
        scrollView.addSubview(topRatedHorizontalList)
        
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        
        let upComingGesture = UITapGestureRecognizer(target: self, action: #selector(navigateUpComingList))
        largeHorizontalPager.addTitleTapGesture(gesture: upComingGesture)
        
        let trendingGesture = UITapGestureRecognizer(target: self, action: #selector(navigateTrendList))
        trendingHorizontalList.addTitleTapGesture(gesture: trendingGesture)
        
        let popularGesture = UITapGestureRecognizer(target: self, action: #selector(navigatePopularList))
        popularHorizontalList.addTitleTapGesture(gesture: popularGesture)
        
        let topRatedGesture = UITapGestureRecognizer(target: self, action: #selector(navigateTopRatedList))
        topRatedHorizontalList.addTitleTapGesture(gesture: topRatedGesture)
        
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
        largeHorizontalPager.initStyle()
        trendingHorizontalList.initStyle()
        popularHorizontalList.initStyle()
        topRatedHorizontalList.initStyle()
    }
    
    override func bindObservable() {
        viewModel.upComingMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.largeHorizontalPager.addAllMovie(list: movieList)
            }
        }
        viewModel.trendingMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.trendingHorizontalList.addAllMovie(list: movieList)
            }
        }
        viewModel.popularMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.popularHorizontalList.addAllMovie(list: movieList)
            }
        }
        viewModel.topRatedMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.topRatedHorizontalList.addAllMovie(list: movieList)
            }
        }
    }
    
    @objc func navigateUpComingList() {
        navigateList(title: LocalizableKeys.Home.upComingTitle.getLocalized())
    }
    
    @objc func navigateTrendList() {
        navigateList(title: LocalizableKeys.Home.trendingTitle.getLocalized())
    }
    
    @objc func navigatePopularList() {
        navigateList(title: LocalizableKeys.Home.popularTitle.getLocalized())
    }
    
    @objc func navigateTopRatedList() {
        navigateList(title: LocalizableKeys.Home.topRatedTitle.getLocalized())
    }
    
    private func navigateList(title:String) {
        let movieListVC = MovieListViewControler()
        movieListVC.listTitle = title
        navigationController?.pushViewController(movieListVC, animated: true)
    }
}


