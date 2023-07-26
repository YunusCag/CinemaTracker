//
//  HomeViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 12.06.2023.
//

import UIKit
import SnapKit
import GoogleMobileAds


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
        let horizonal = MovieHorizontalPageList(frame: CGRect(x: 0, y: 12, width: screenWidth, height: 250))
        horizonal.setTitle(title: LocalizableKeys.Home.upComingTitle.getLocalized())
        return horizonal
    }()
    
    private lazy var bannerView:GADBannerView = {
        let banner = GADBannerView()
        banner.frame = CGRect(x: (screenWidth / 2 - 160), y: largeHorizontalPager.frame.maxY + 50, width: 320, height: 100)
        banner.adUnitID = Constant.AdmobUtil.bannerAdId
        banner.load(GADRequest())
        banner.backgroundColor = .clear
        return banner
    }()
    
    private lazy var trendingHorizontalList: MovieSmallHorizontalList = {
        let horizontal = MovieSmallHorizontalList(frame: CGRect(x: 0, y: bannerView.frame.maxY + 10, width: screenWidth, height: 200))
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
    
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self,name: .settingsChange,object: nil)
    }
    
    override func setUpView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bannerView.rootViewController = self
        
        scrollView.addSubview(largeHorizontalPager)
        scrollView.addSubview(bannerView)
        
        scrollView.addSubview(trendingHorizontalList)
        scrollView.addSubview(popularHorizontalList)
        scrollView.addSubview(topRatedHorizontalList)
        
        scrollView.contentSize = CGSize(width: screenWidth, height: 1150)
        
        let upComingGesture = UITapGestureRecognizer(target: self, action: #selector(navigateUpComingList))
        largeHorizontalPager.addTitleTapGesture(gesture: upComingGesture)
        
        let trendingGesture = UITapGestureRecognizer(target: self, action: #selector(navigateTrendList))
        trendingHorizontalList.addTitleTapGesture(gesture: trendingGesture)
        
        let popularGesture = UITapGestureRecognizer(target: self, action: #selector(navigatePopularList))
        popularHorizontalList.addTitleTapGesture(gesture: popularGesture)
        
        let topRatedGesture = UITapGestureRecognizer(target: self, action: #selector(navigateTopRatedList))
        topRatedHorizontalList.addTitleTapGesture(gesture: topRatedGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onSettingChange), name: .settingsChange, object: nil)
        
        
        
        self.largeHorizontalPager.listener = self.movieDetailListener
        self.trendingHorizontalList.listener = self.movieDetailListener
        self.popularHorizontalList.listener = self.movieDetailListener
        self.topRatedHorizontalList.listener = self.movieDetailListener
        
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
                self.largeHorizontalPager.saveMovieList(list: movieList)
            }
        }
        viewModel.upComingErrorMessage.bind { message in
            if message == nil {
                return
            }
            DispatchQueue.main.async {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onUpComingRefresh))
                self.largeHorizontalPager.saveError(errorMessage: message,gesture: gesture)
            }
        }
        
        viewModel.trendingMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.trendingHorizontalList.saveMovieList(list: movieList)
            }
        }
        viewModel.trendingErrorMessage.bind { message in
            if message == nil {
                return
            }
            DispatchQueue.main.async {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onTrendingRefresh))
                self.trendingHorizontalList.saveError(errorMessage: message, gesture: gesture)
            }
        }
        
        viewModel.popularMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.popularHorizontalList.saveMovieList(list: movieList)
            }
        }
        viewModel.popularErrorMessage.bind { message in
            if message == nil {
                return
            }
            DispatchQueue.main.async {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onPopularRefresh))
                self.popularHorizontalList.saveError(errorMessage: message, gesture: gesture)
            }
        }
        
        viewModel.topRatedMovieList.bind { movieList in
            DispatchQueue.main.async {
                self.topRatedHorizontalList.saveMovieList(list: movieList)
            }
        }
        
        viewModel.topRatedErrorMessage.bind { message in
            if message == nil {
                return
            }
            DispatchQueue.main.async {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onTopRatedRefresh))
                self.topRatedHorizontalList.saveError(errorMessage: message, gesture: gesture)
            }
        }
    }
    
    @objc func onUpComingRefresh() {
        self.viewModel.getUpComing()
    }
    
    @objc func onTrendingRefresh() {
        self.viewModel.getTrending()
    }
    
    @objc func onPopularRefresh() {
        self.viewModel.getPopular()
    }
    
    @objc func onTopRatedRefresh() {
        self.viewModel.getTopRated()
    }
    
    
    @objc func onSettingChange() {
        print("onSettingChange called.")
        self.viewModel.onInit()
    }
    
    @objc func navigateUpComingList() {
        navigateList(title: LocalizableKeys.Home.upComingTitle.getLocalized(),listType: .UpComing)
    }
    
    @objc func navigateTrendList() {
        navigateList(title: LocalizableKeys.Home.trendingTitle.getLocalized(),listType: .Trending)
    }
    
    @objc func navigatePopularList() {
        navigateList(title: LocalizableKeys.Home.popularTitle.getLocalized(),listType: .Popular)
    }
    
    @objc func navigateTopRatedList() {
        navigateList(title: LocalizableKeys.Home.topRatedTitle.getLocalized(),listType: .TopRated)
    }
    
    private func navigateList(title:String, listType:MovieListType) {
        let movieListVC = MovieListViewControler()
        movieListVC.listTitle = title
        movieListVC.listType = listType
        navigationController?.pushViewController(movieListVC, animated: true)
    }
}


