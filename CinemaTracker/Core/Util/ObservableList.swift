//
//  ObservableList.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 3.07.2023.
//

import Foundation


final class ObservableList<T> {
    var values: [T] = []
    
    private var listener :(([T]) -> Void)?
    

    func bind(_ listener : @escaping ([T])-> Void) {
        listener(values)
        self.listener = listener
    }
    
    func append(value: T) {
        self.values.append(value)
        self.listener?(values)
    }
    
    func appendAllValue(list:[T]) {
        values.append(contentsOf: list)
        self.listener?(values)
    }
    func clear(){
        values.removeAll(keepingCapacity: false)
        self.listener?([])
    }
    
}
