//
//  MovieLargeCollectionCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 3.07.2023.
//

import Foundation
import UIKit
import SnapKit
import AlamofireImage

class MovieLargeCollectionCell: UICollectionViewCell {
    
    private lazy var largeImage: MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var labelName: AppLabel = AppLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    static let identifier = "movie_large_cell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        addSubview(labelName)
        addSubview(largeImage)
        
        
        labelName.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        largeImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        bringSubviewToFront(labelName)
        
        labelName.initStyle(typograph: .normal1, color: AppTheme.shared.colors.whiteColor)
        labelName.numberOfLines = 1
        labelName.textAlignment = .center
        labelName.lineBreakMode = .byTruncatingTail
    }
    
    
    func saveMovie(movie:MovieModel) {
        labelName.text = movie.title ?? Constant.StringParameter.EMPTY_STRING
        largeImage.saveUrl(path: movie.posterPath)
    }
}
