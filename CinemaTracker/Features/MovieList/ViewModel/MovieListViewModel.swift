//
//  MovieListViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation


final class MovieListViewModel : CoreViewModel {
    
    private let service: MovieServiceProtocol = MovieService.shared
    private let regionManager: RegionProtocol = RegionManager.shared
    private let languageManager: LanguageProtocol = LanguageTypeManager.shared
    
    var listType: MovieListType = .UpComing
    var listErrorMessage = ObservableObject<String?>(nil)
    var isLoading = ObservableObject<Bool>(true)
    
    var genreList = ObservableList<GenreModel>()
    
    var currentPage:Int = 1
    var totalPage: Int = 1
    
    let movieList = ObservableList<MovieModel>()
    private var genreIds: Int? = nil
    
    func onInit() {
        getMovieList()
        getGenreList()
    }
    
    func changeByGenreId(id:Int) {
        currentPage = 1
        genreIds = nil
        if id != -1 {
            genreIds = id
        }
        movieList.clear()
        getMovieList()
    }
    
    func getPagination() {
        if currentPage <= totalPage && !isLoading.value  {
            self.getMovieList()
        }
    }
    
    private func getMovieList(){
        self.isLoading.value = true
        service.fetchMovieList(
            page: currentPage,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue,
            genreIds: genreIds,
            path: getPath()
        ) { result in
                self.isLoading.value = false
                switch(result) {
                case .success(let response):
                    if let list = response.results {
                        self.currentPage += 1
                        self.movieList.appendAllValue(list: list)
                    }
                    if let total = response.totalPages {
                        self.totalPage = total
                        print(self.totalPage)
                    }
                case .failure(let error):
                    self.listErrorMessage.value = error.localizedDescription
                }
            }
    }
    
    private func getGenreList() {
        service.fetchGenreList(
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue
        ) { result in
            switch(result) {
            case .success(let response):
                if let list = response.genres {
                    self.genreList.appendAllValue(list: list)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPath() -> MovieServicePath {
        var path = MovieServicePath.UPCOMING_MOVIES_URL
        switch(listType){
        case .UpComing:
            path = .UPCOMING_MOVIES_URL
        case .Trending:
            path = .TRENDING_MOVIES_URL
        case .Popular:
            path = .POPULAR_MOVIES_URL
        case .TopRated:
            path = .TOP_RATED_MOVIES_URL
        }
        return path
    }
}
