//
//  CastCrewCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 20.07.2023.
//

import UIKit
import SnapKit

class CastCrewCell: UICollectionViewCell {
    
    
    private lazy var movieImage:MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = image.frame.height / 2
        return image
    }()
    
    private lazy var labelName: AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .normal1,color: AppTheme.shared.colors.textPrimary)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        return label
    }()
    
    private lazy var labelDescription: AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .normal2,color: AppTheme.shared.colors.secondaryGray)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        return label
    }()
    
    static let identifier = "cast_crew_cell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(movieImage)
        addSubview(labelName)
        addSubview(labelDescription)
        
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        labelName.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        labelDescription.snp.makeConstraints { make in
            make.top.equalTo(labelName.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    func save(
        profilePath:String?,
        name: String,
        description: String
    ) {
        movieImage.saveUrl(path: profilePath)
        labelName.text = name
        labelDescription.text = description
    }
    
}
