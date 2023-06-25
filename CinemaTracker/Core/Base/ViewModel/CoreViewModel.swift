//
//  CoreViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.06.2023.
//

import Foundation

protocol CoreViewModel {
    init()
    func onInit() // it's called in the viewDidload.
}
