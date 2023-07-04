//
//  NetworkError.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation



enum NetworkErrorType {
    case NetworkConnectionError
    case ParsingObjectError
}

struct NetworkError: Error {
    let title: String? = nil
    let type: NetworkErrorType
}

