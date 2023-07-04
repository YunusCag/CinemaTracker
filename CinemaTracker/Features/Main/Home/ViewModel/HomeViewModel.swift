//
//  HomeViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.06.2023.
//

import Foundation


final class HomeViewModel : CoreViewModel {
    private let service: IMovieService = MovieService.shared
    
    let movieList = ObservableList<MovieModel> ()
    let errorMessage = ObservableObject<String?> (nil)
    
    init() {
        
    }
    
    func onInit() {
        service.fetchMovieList(
            page: 1,
            lang: "en",
            region: "US",
            genreIds: nil,
            path: .UPCOMING_MOVIES_URL
        ) { result in
            switch result {
            case .success(let response):
                if let list = response.results{
                    self.movieList.appendAllValue(list: list)
                }
                
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
}
