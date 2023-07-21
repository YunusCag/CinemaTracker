//
//  MovieDetailViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 18.07.2023.
//

import Foundation


final class MovieDetailViewModel: CoreViewModel {
    
    
    var movie:MovieModel? = nil
    
    private let service: MovieServiceProtocol = MovieService.shared
    private let regionManager: RegionProtocol = RegionManager.shared
    private let languageManager: LanguageProtocol = LanguageTypeManager.shared
    
    
    var movieDetail = ObservableObject<MovieDetailResponse?>(nil)
    var isDetailLoading = ObservableObject<Bool>(false)
    var detailErrorMesssage = ObservableObject<String?>(nil)
    
    var casts = ObservableList<CastModel>()
    var crews = ObservableList<CrewModel>()
    
    var videoList = ObservableList<MovieVideoModel>()
    
    func onInit() {
        if let movieId = movie?.id {
            getMovieDetail(movieId: movieId)
            getCastCrew(movieId: movieId)
            getMovieVideo(movieId: movieId)
        }
    }
    
    
    
    private func getMovieDetail(movieId:Int) {
        self.isDetailLoading.value = true
        service.fetchMovieDetail(
            movieId: movieId,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue
        ) { result in
            self.isDetailLoading.value = false
            switch(result) {
            case .success(let response):
                self.movieDetail.value = response
            case .failure(let error):
                self.detailErrorMesssage.value = error.localizedDescription
            }
        }
    }
    
    private func getCastCrew(movieId: Int) {
        service.fetCastCrew(
            movieId: movieId,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue
        ) { result in
            switch(result) {
            case .success(let response):
                if let castList = response.casts {
                    self.casts.appendAllValue(list: castList)
                }
                if let crewList = response.crews {
                    self.crews.appendAllValue(list: crewList)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getMovieVideo(movieId: Int) {
        service.fetchMovieVideo(
            movieId: movieId,
            lang: languageManager.languageType.rawValue,
            region: regionManager.region.rawValue
        ){ result in
            switch(result) {
            case .success(let response):
                if let results = response.results {
                    let list = results.filter { video in
                        let isTeaserOrTrailer = (video.type?.lowercased() == VideoType.Trailer.rawValue.lowercased()) || (video.type?.lowercased() == VideoType.Teaser.rawValue.lowercased())
                        return isTeaserOrTrailer && (video.site?.lowercased() == VideoSite.Youtube.rawValue.lowercased())
                    }
                    self.videoList.appendAllValue(list: list)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
