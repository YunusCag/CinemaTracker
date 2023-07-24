//
//  CoreDataHelper.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 24.07.2023.
//

import CoreData
import UIKit


protocol CoreDataHelperProtocol {
    func fetchMovies(completion:@escaping (Result<[MovieModel], Error>) -> Void)
    func deleteMovie(id: Int)
    func insertMovie(movie: MovieModel, completion: @escaping (Result<MovieModel, Error>) -> Void)
    
}

enum MovieEntityKey: String {
    case id = "id"
    case title = "title"
    case posterPath = "posterPath"
    case releaseDate = "releaseDate"
    case overview = "overview"
}

final class CoreDataHelper: CoreDataHelperProtocol {
    
    static let shared = CoreDataHelper()
    
    private init() {}
    
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }()
    
    
    func fetchMovies(completion:@escaping (Result<[MovieModel], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: movieEntityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            var movies: [MovieModel] = []
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    let id = (result.value(forKey: MovieEntityKey.id.rawValue) as? Int)
                    let title = (result.value(forKey: MovieEntityKey.title.rawValue) as? String)
                    let posterPath = (result.value(forKey: MovieEntityKey.posterPath.rawValue) as? String)
                    let releaseDate = (result.value(forKey: MovieEntityKey.releaseDate.rawValue) as? String)
                    let overview = (result.value(forKey: MovieEntityKey.overview.rawValue) as? String)
                    
                    let movie = MovieModel(
                       id: id,
                       overview: overview,
                       posterPath: posterPath,
                       releaseDate: releaseDate,
                       title: title
                    )
                    movies.append(movie)
                }
            }
            completion(.success(movies))
        }catch let error {
            completion(.failure(error))
        }
    }
    
    
    func deleteMovie(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: movieEntityName)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if result.value(forKey: MovieEntityKey.id.rawValue) is Int {
                    self.context.delete(result)
                    try context.save()
                }
            }
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func insertMovie(movie: MovieModel, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        let movieEntity = NSEntityDescription.insertNewObject(forEntityName: movieEntityName, into: context)
        
        movieEntity.setValue(movie.id, forKey: MovieEntityKey.id.rawValue)
        movieEntity.setValue(movie.title, forKey: MovieEntityKey.title.rawValue)
        movieEntity.setValue(movie.overview, forKey: MovieEntityKey.overview.rawValue)
        movieEntity.setValue(movie.posterPath, forKey: MovieEntityKey.posterPath.rawValue)
        movieEntity.setValue(movie.releaseDate, forKey: MovieEntityKey.releaseDate.rawValue)
        
        do {
            try context.save()
            completion(.success(movie))
        }catch let error {
            completion(.failure(error))
        }
    }
    
    
    private let movieEntityName = "Movie"
}
