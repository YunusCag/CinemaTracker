//
//  VideoListView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 21.07.2023.
//

import UIKit
import SnapKit


final class VideoListView: UIView,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private lazy var screenWidth: CGFloat = frame.width
    private lazy var screenHeight: CGFloat = frame.height
    
    
    private var labelTitle: AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .subtitle,color: AppTheme.shared.colors.textPrimary)
        label.textAlignment = .left
        label.text = LocalizableKeys.MovieDetail.trailer.getLocalized()
        return label
    }()
    
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
        collectionView.register(VideoThumbnailCell.self, forCellWithReuseIdentifier: VideoThumbnailCell.identifier)
        return collectionView
    }()
    
    private var videos:[MovieVideoModel] = []
    
    var listener:((MovieVideoModel) -> Void)? = nil
    
    
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
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    
    
    func save(list: [MovieVideoModel]) {
        self.videos = list
        self.collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoThumbnailCell.identifier, for: indexPath) as! VideoThumbnailCell
        let video = self.videos[indexPath.row]
        
        cell.save(
            key: video.key,
            name: video.name ?? Constant.StringParameter.EMPTY_STRING
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.row]
        self.listener?(video)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
}
