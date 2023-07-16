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
    
    let trendingMovieList = ObservableList<MovieModel> ()
    let trendingErrorMessage = ObservableObject<String?> (nil)
    
    let popularMovieList = ObservableList<MovieModel> ()
    let popularErrorMessage = ObservableObject<String?> (nil)
    
    let topRatedMovieList = ObservableList<MovieModel> ()
    let topRatedErrorMessage = ObservableObject<String?> (nil)
    
    
    func onInit() {
        getUpComing()
        getTrending()
        getPopular()
        getTopRated()
    }
    
    private func getUpComing() {
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .UPCOMING_MOVIES_URL
        ) { result in
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
    
    private func getTrending() {
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .TRENDING_MOVIES_URL
        ) { result in
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
    
    private func getPopular() {
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .POPULAR_MOVIES_URL
        ) { result in
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
    
    private func getTopRated() {
        service.fetchMovieList(
            page: 1,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: nil,
            path: .TOP_RATED_MOVIES_URL
        ) { result in
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
