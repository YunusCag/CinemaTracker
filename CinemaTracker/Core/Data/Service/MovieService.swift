//
//  MovieService.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation
import Alamofire


protocol MovieServiceProtocol {
    
    func fetchMovieList(
        page: Int,
        lang: String,
        region: String,
        genreIds: [Int]?,
        path: MovieServicePath,
        completion: @escaping (Result<MovieListResponse, Error>) -> Void
    )
}


final class MovieService : MovieServiceProtocol {
    static let shared: MovieService = MovieService()
    
    private let url = ApiConstant.BASE_URL.rawValue
    
    private init() {
        
    }
    
    func fetchMovieList(
        page: Int,
        lang: String,
        region: String,
        genreIds: [Int]?,
        path: MovieServicePath,
        completion: @escaping (Result<MovieListResponse, Error>) -> Void
    ) {
        var paramters = [
            Constant.NetworkParamKey.apiKey : ApiConstant.API_KEY.rawValue,
            Constant.NetworkParamKey.page : page,
            Constant.NetworkParamKey.language : lang,
            Constant.NetworkParamKey.region : region,
        ] as [String : Any]
        
        if genreIds != nil {
            paramters[Constant.NetworkParamKey.withGenres] = genreIds
        }
        
        guard var url = URL(string:url) else {
            return
        }
        url.append(path: path.rawValue)
        
        AF.request(
            url,
            parameters: paramters
        ).responseDecodable(of: MovieListResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
            guard let movieResponse = response.value else {
                completion(.failure(NetworkError(type: .ParsingObjectError)))
                return
            }
            completion(.success(movieResponse))
        }
        
    }
}


