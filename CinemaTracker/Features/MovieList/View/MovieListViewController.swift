//
//  MovieListViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit
import CHTCollectionViewWaterfallLayout
import GoogleMobileAds

final class MovieListViewControler: CoreViewController <MovieListViewModel>, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    
    var listTitle: String? = nil
    var listType: MovieListType = .UpComing
    
    private var movieList: [MovieModel] = []
    private var isLoading: Bool = true
    
    private var genreList: [GenreModel] = []
    private var selectedGenreIndex = 0
    
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
        collectionView.isPagingEnabled = true
        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: MovieImageCell.identifier)
        collectionView.register(PaginationCell.self, forCellWithReuseIdentifier: PaginationCell.identifier)
        return collectionView
    }()
    
    private lazy var bannerView:GADBannerView = {
        let banner = GADBannerView()
        banner.frame = CGRect(x: (view.frame.width / 2 - 160), y: 0, width: 320, height: 50)
        banner.adUnitID = Constant.AdmobUtil.bannerAdId
        banner.load(GADRequest())
        banner.backgroundColor = .clear
        return banner
    }()
    
    override func setUpView() {
        self.title = listTitle ?? Constant.StringParameter.EMPTY_STRING
        viewModel.listType = self.listType
        
        view.addSubview(collectionView)
        view.addSubview(bannerView)
        bannerView.rootViewController = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        bannerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        view.bringSubviewToFront(bannerView)
        
        self.navigationController?.navigationBar.tintColor = AppTheme.shared.colors.secondary
        navigationItem.backButtonTitle = Constant.StringParameter.EMPTY_STRING
        
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
    }
    
    override func bindObservable() {
        viewModel.movieList.bind { movies in
            DispatchQueue.main.async {
                self.movieList = movies
                self.collectionView.reloadData()
            }
        }
        viewModel.isLoading.bind { isLoading in
            DispatchQueue.main.async {
                self.isLoading = isLoading
                self.collectionView.reloadData()
            }
        }
        viewModel.genreList.bind { genres in
            if genres.isEmpty {
                return
            }
            
            DispatchQueue.main.async {
                self.genreList = genres
                self.createRightActionItem()
            }
        }
    }
    
    private func createRightActionItem() {
        let image = UIImage(systemName: "bookmark.fill")
        let button = UIBarButtonItem(image: image ,style: .done, target: self, action: #selector(openBottomSheet))
        button.tintColor = AppTheme.shared.colors.secondary
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func openBottomSheet() {
        let genreVC = GenreListViewController()
        genreVC.genreList = self.genreList
        genreVC.selectedGenreIndex = self.selectedGenreIndex
        genreVC.onClickListener = { index in
            self.movieList.removeAll(keepingCapacity: false)
            if index == self.selectedGenreIndex {
                return
            }
            self.selectedGenreIndex = index
            if index == 0 {
                self.viewModel.changeByGenreId(id: -1)
                return
            }
            let genre = self.genreList[index - 1]
            if let id = genre.id {
                self.viewModel.changeByGenreId(id: id)
            }
            
        }
        genreVC.modalPresentationStyle = .pageSheet

        if let sheet = genreVC.sheetPresentationController {
            sheet.detents = [.custom { _ in
                return 100
            }]
        }
        present(genreVC, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.movieDetailListener(self.movieList[indexPath.row])
    }
}
