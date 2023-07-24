//
//  FavouriteViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import Foundation


final class FavouriteViewModel: CoreViewModel {
    
    private lazy var coreDataHelper: CoreDataHelperProtocol = CoreDataHelper.shared
    
    var movies = ObservableList<MovieModel>()
    
    func onInit() {
        //getLikedMovies()
    }
    
    func getLikedMovies() {
        self.coreDataHelper.fetchMovies { result in
            switch(result) {
            case .success(let movieList):
                self.movies.clear(callListener: false)
                self.movies.appendAllValue(list: movieList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
