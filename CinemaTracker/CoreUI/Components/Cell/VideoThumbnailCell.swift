//
//  VideoThumbnailCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 21.07.2023.
//

import UIKit
import SnapKit


class VideoThumbnailCell: UICollectionViewCell {
    
    private lazy var thumbnailImage: MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 125))
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var playIconImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        image.image = UIImage(systemName: "play.rectangle.fill")
        image.tintColor = .red
        return image
    }()
    
    private lazy var labelName: AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .normal1,color: AppTheme.shared.colors.textPrimary)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    static let identifier = "video_thumnail_cell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(thumbnailImage)
        addSubview(labelName)
        addSubview(playIconImage)
        
        thumbnailImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(125)
        }
        
        playIconImage.snp.makeConstraints { make in
            make.centerX.equalTo(thumbnailImage.snp.centerX)
            make.centerY.equalTo(thumbnailImage.snp.centerY)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        
        labelName.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func save(
        key:String?,
        name: String
    ){
        thumbnailImage.saveUrl(videoId: key)
        labelName.text = name
    }
}
