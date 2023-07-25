//
//  HomeViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.06.2023.
//

import Foundation


final class HomeViewModel : CoreViewModel {
    private let service: MovieServiceProtocol = MovieService.shared
    private let regionManager: RegionProtocol = RegionManager.shared
    private let languageManager: LanguageProtocol = LanguageTypeManager.shared
    
    let upComingMovieList = ObservableList<MovieModel> ()
    let upComingErrorMessage = ObservableObject<String?> (nil)
    var isUpComingLoading = false
    
    let trendingMovieList = ObservableList<MovieModel> ()
    let trendingErrorMessage = ObservableObject<String?> (nil)
    private var isTrendingLoading = false
    
    let popularMovieList = ObservableList<MovieModel> ()
    let popularErrorMessage = ObservableObject<String?> (nil)
    private var isPopularLoading = false
    
    let topRatedMovieList = ObservableList<MovieModel> ()
    let topRatedErrorMessage = ObservableObject<String?> (nil)
    private var isTopRatedLoading = false
    
    
    func onInit() {
        getUpComing()
        getTrending()
        getPopular()
        getTopRated()
    }
    
    func getUpComing() {
        if self.isUpComingLoading {
            return
        }
        
        self.isUpComingLoading = true
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .UPCOMING_MOVIES_URL
        ) { result in
            self.isUpComingLoading = false
            switch result {
            case .success(let response):
                if let list = response.results{
                    self.upComingMovieList.clear()
                    self.upComingMovieList.appendAllValue(list: list)
                }
                
            case .failure(let error):
                self.upComingErrorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getTrending() {
        if self.isTrendingLoading {
            return
        }
        self.isTrendingLoading = true
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .TRENDING_MOVIES_URL
        ) { result in
            self.isTrendingLoading = false
            switch result {
            case .success(let response):
                if let list = response.results{
                    self.trendingMovieList.clear()
                    self.trendingMovieList.appendAllValue(list: list)
                }
                
            case .failure(let error):
                self.trendingErrorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getPopular() {
        if self.isPopularLoading {
            return
        }
        self.isPopularLoading = true
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .POPULAR_MOVIES_URL
        ) { result in
            self.isPopularLoading = false
            switch result {
            case .success(let response):
                if let list = response.results{
                    self.popularMovieList.clear()
                    self.popularMovieList.appendAllValue(list: list)
                }
                
            case .failure(let error):
                self.popularErrorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getTopRated() {
        if self.isTopRatedLoading {
            return
        }
        self.isTopRatedLoading = true
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .TOP_RATED_MOVIES_URL
        ) { result in
            self.isTopRatedLoading = false
            switch result {
            case .success(let response):
                if let list = response.results{
                    self.topRatedMovieList.clear()
                    self.topRatedMovieList.appendAllValue(list: list)
                }
                
            case .failure(let error):
                self.topRatedErrorMessage.value = error.localizedDescription
            }
        }
    }
}
