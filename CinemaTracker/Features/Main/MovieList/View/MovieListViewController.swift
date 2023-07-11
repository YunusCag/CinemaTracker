//
//  MovieListViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit
import CHTCollectionViewWaterfallLayout

final class MovieListViewControler: CoreViewController <MovieListViewModel>, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    
    var listTitle: String? = nil
    var listType: MovieListType = .UpComing
    
    private var movieList: [MovieModel] = []
    private var isLoading: Bool = true
    
    private lazy var collectionView: UICollectionView = {
       let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        layout.sectionInset = .zero
        layout.minimumColumnSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: MovieImageCell.identifier)
        collectionView.register(PaginationCell.self, forCellWithReuseIdentifier: PaginationCell.identifier)
        return collectionView
    }()
    
    override func setUpView() {
        self.title = listTitle ?? Constant.StringParameter.EMPTY_STRING
        viewModel.listType = self.listType
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
    }
    
    override func bindObservable() {
        viewModel.movieList.bind { movies in
            DispatchQueue.main.async {
                self.movieList.append(contentsOf: movies)
                self.collectionView.reloadData()
            }
        }
        viewModel.isLoading.bind { isLoading in
            self.isLoading = isLoading
            self.collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoading && self.movieList.count - 1 == indexPath.row {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaginationCell.identifier, for: indexPath) as! PaginationCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieImageCell.identifier, for: indexPath) as! MovieImageCell
        let movie = self.movieList[indexPath.row]
        cell.saveMovie(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let movieModel = self.movieList[indexPath.row]
        return CGSize(width: view.frame.width / 2, height: movieModel.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieList.count - 1 {
            self.viewModel.getPagination()
        }
    }
    
}
