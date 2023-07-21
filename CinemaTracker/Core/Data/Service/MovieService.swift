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
        genreIds: Int?,
        path: MovieServicePath,
        completion: @escaping (Result<MovieListResponse, Error>) -> Void
    )
    func fetchGenreList(
        lang: String,
        region: String,
        completion: @escaping (Result<GenreListResponse, Error>) -> Void
    )
    
    func fetchMovieDetail(
        movieId: Int,
        lang: String,
        region: String,
        completion: @escaping (Result<MovieDetailResponse, Error>) -> Void
    )
    
    func fetCastCrew(
        movieId: Int,
        lang: String,
        region: String,
        completion: @escaping (Result<CastCrewResponse, Error>) -> Void
    )
    
    func fetchMovieVideo(
        movieId: Int,
        lang: String,
        region: String,
        completion: @escaping (Result<MovieVideoResponse, Error>) -> Void
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
        genreIds: Int?,
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
                return
            }
            
            guard let movieResponse = response.value else {
                completion(.failure(NetworkError(type: .ParsingObjectError)))
                return
            }
            completion(.success(movieResponse))
        }
    }
    
    func fetchGenreList(
        lang: String,
        region: String,
        completion: @escaping (Result<GenreListResponse, Error>) -> Void
    ) {
        let parameters = [
            Constant.NetworkParamKey.apiKey : ApiConstant.API_KEY.rawValue,
            Constant.NetworkParamKey.language : lang,
            Constant.NetworkParamKey.region : region
        ] as [String : Any]
        
        guard var url = URL(string: url) else {
            return
        }
        url.append(path: MovieServicePath.GENRE_LIST_MOVIES_URL.rawValue)
        
        AF.request(
            url,
            parameters: parameters
        ).responseDecodable(of:GenreListResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let genreListResponse = response.value else {
                completion(.failure(NetworkError(type: .ParsingObjectError)))
                return
            }
            completion(.success(genreListResponse))
        }
    }
    
    func fetchMovieDetail(
        movieId: Int,
        lang: String,
        region: String,
        completion: @escaping (Result<MovieDetailResponse, Error>) -> Void
    ){
        let parameters = [
            Constant.NetworkParamKey.apiKey : ApiConstant.API_KEY.rawValue,
            Constant.NetworkParamKey.language : lang,
            Constant.NetworkParamKey.region : region
        ] as [String : Any]
        
        guard var url = URL(string: url) else {
            return
        }
        url.append(path: MovieServicePath.getMovieDetailUrl(movieId: movieId))
        
        AF.request(
            url,
            parameters: parameters
        ).responseDecodable(of: MovieDetailResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let movieDetail = response.value else {
                completion(.failure(NetworkError(type: .ParsingObjectError)))
                return
            }
            completion(.success(movieDetail))
        }
    }
    
    func fetCastCrew(
        movieId: Int,
        lang: String,
        region: String,
        completion: @escaping (Result<CastCrewResponse, Error>) -> Void
    ){
        let parameters = [
            Constant.NetworkParamKey.apiKey : ApiConstant.API_KEY.rawValue,
            Constant.NetworkParamKey.language : lang,
            Constant.NetworkParamKey.region : region
        ] as [String : Any]
        
        guard var url = URL(string: url) else {
            return
        }
        url.append(path: MovieServicePath.getCreditPath(movieId: movieId))
        AF.request(
            url,
            parameters: parameters
        ).responseDecodable(of: CastCrewResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let castCrew = response.value else {
                completion(.failure(NetworkError(type: .ParsingObjectError)))
                return
            }
            completion(.success(castCrew))
        }
    }
    
    
    func fetchMovieVideo(
        movieId: Int,
        lang: String,
        region: String,
        completion: @escaping (Result<MovieVideoResponse, Error>) -> Void
    ){
        let parameters = [
            Constant.NetworkParamKey.apiKey : ApiConstant.API_KEY.rawValue,
            Constant.NetworkParamKey.language : lang,
            Constant.NetworkParamKey.region : region
        ] as [String : Any]
        
        guard var url = URL(string: url) else {
            return
        }
        url.append(path: MovieServicePath.getMovieVideoPath(movieId: movieId))
        AF.request(
            url,
            parameters: parameters
        ).responseDecodable(of: MovieVideoResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let videoResponse = response.value else {
                completion(.failure(NetworkError(type: .ParsingObjectError)))
                return
            }
            completion(.success(videoResponse))
        }
    }
}


