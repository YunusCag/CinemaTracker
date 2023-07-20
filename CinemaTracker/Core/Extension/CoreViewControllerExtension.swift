//
//  CoreViewControllerExtension.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 18.07.2023.
//

import Foundation


extension CoreViewController {
    var movieDetailListener: (MovieModel) -> Void {
        get {
            return { (movie: MovieModel) in
                let controller = MovieDetailViewController()
                controller.movie = movie
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
