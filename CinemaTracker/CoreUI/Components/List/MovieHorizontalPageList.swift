//
//  MovieHorizontalPageList.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 2.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class MovieHorizontalPageList: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    private lazy var screenWidth: CGFloat = frame.width
    private lazy var screenHeight: CGFloat = frame.height
    
    private lazy var labelTitle: AppLabel = AppLabel()
    
    private var movieList: [MovieModel] = []
    private var currentIndex = 0
    private var timer: Timer? = nil
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieLargeCollectionCell.self, forCellWithReuseIdentifier: MovieLargeCollectionCell.identifier)
        collectionView.isScrollEnabled = false
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
            make.height.equalTo(250)
        }
        startTimer()
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieLargeCollectionCell.identifier, for: indexPath) as! MovieLargeCollectionCell
        let movieModel = self.movieList[indexPath.row]
        cell.saveMovie(movie: movieModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 24, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    @objc func scrollNext() {
        if currentIndex < movieList.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Constant.DurationUtil.HOME_AUTO_SCROLL_DURATION, target: self, selector: #selector(scrollNext), userInfo: nil, repeats: true);
    }
}
