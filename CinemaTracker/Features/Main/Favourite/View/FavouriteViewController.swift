//
//  FavouriteViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import UIKit
import SnapKit

final class FavouriteViewController: CoreViewController<FavouriteViewModel>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FavouriteMovieCell.self, forCellWithReuseIdentifier: FavouriteMovieCell.identifier)
        return collectionView
    }()
    
    private lazy var emptyView: EmptyView = {
        let empty = EmptyView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        empty.isHidden = true
        return empty
    }()
    
    private var movieList:[MovieModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getLikedMovies()
    }
    
    override func setUpView() {
        view.addSubview(collectionView)
        view.addSubview(emptyView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(200)
        }
        
        self.navigationController?.navigationBar.tintColor = AppTheme.shared.colors.secondary
        navigationItem.backButtonTitle = Constant.StringParameter.EMPTY_STRING
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
    }
    
    override func bindObservable() {
        viewModel.movies.bind { movieList in
            DispatchQueue.main.async {
                self.movieList = movieList
                if !movieList.isEmpty {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.emptyView.isHidden = true
                } else {
                    self.collectionView.isHidden = true
                    self.emptyView.isHidden = false
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteMovieCell.identifier, for: indexPath) as! FavouriteMovieCell
        let movie = self.movieList[indexPath.row]
        cell.save(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movieList[indexPath.row]
        self.movieDetailListener(movie)
    }
    
    
}
