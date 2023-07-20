//
//  MovieSmallCollectionCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 5.07.2023.
//

import Foundation
import UIKit
import SnapKit
import AlamofireImage


class MovieSmallCollectionCell: UICollectionViewCell {
    
    
    private lazy var imageSmall: MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var labelName: AppLabel = AppLabel()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = AppTheme.shared.colors.secondary
        indicator.startAnimating()
        return indicator
    }()
    
    
    static let identifier = "movie_small_cell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(imageSmall)
        addSubview(labelName)
        
        imageSmall.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(120)
        }
        labelName.snp.makeConstraints { make in
            make.top.equalTo(imageSmall.snp.bottom).offset(4)
            make.left.equalTo(imageSmall.snp.left)
            make.right.equalTo(imageSmall.snp.right)
        }
        
        labelName.initStyle(typograph: .normal1, color: AppTheme.shared.colors.textPrimary)
        labelName.numberOfLines = 2
        labelName.textAlignment = .center
        labelName.lineBreakMode = .byTruncatingTail
    }
    
    func saveMovie(movie:MovieModel) {
        labelName.text = movie.title ?? Constant.StringParameter.EMPTY_STRING
        imageSmall.saveUrl(path: movie.posterPath)
    }
}
