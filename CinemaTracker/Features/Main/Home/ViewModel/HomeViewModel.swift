//
//  HomeViewModel.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 16.06.2023.
//

import Foundation


final class HomeViewModel : CoreViewModel {
    let isLoading : ObservableObject<Bool?> = ObservableObject(nil)
    
    init() {
        
    }
    
    func onInit() {
        
    }
    
    func changeLoading() {
        self.isLoading.value = true
    }
    
    
}
