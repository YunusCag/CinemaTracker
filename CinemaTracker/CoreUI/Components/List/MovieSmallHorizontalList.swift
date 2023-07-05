//
//  MovieSmallHorizontalList.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 5.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class MovieSmallHorizontalList: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private lazy var screenWidth: CGFloat = frame.width
    private lazy var screenHeight: CGFloat = frame.height
    
    private var movieList: [MovieModel] = []
    private lazy var labelTitle: AppLabel = AppLabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieSmallCollectionCell.self, forCellWithReuseIdentifier: MovieSmallCollectionCell.identifier)
        return collectionView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    
    private func createView() {
        addSubview(labelTitle)
        addSubview(collectionView)
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(screenWidth)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func setTitle(title: String) {
        labelTitle.text = title
    }
    func addAllMovie(list: [MovieModel]) {
        self.movieList.append(contentsOf: list)
        self.collectionView.reloadData()
    }
    
    func initStyle() {
        labelTitle.initStyle(typograph: .subtitle,color: AppTheme.shared.colors.textPrimary)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSmallCollectionCell.identifier, for: indexPath) as! MovieSmallCollectionCell
        let movieModel = self.movieList[indexPath.row]
        cell.saveMovie(movie: movieModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
    
}
