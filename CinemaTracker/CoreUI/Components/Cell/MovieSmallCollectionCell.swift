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
    
    
    private lazy var imageSmall: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.isHidden = true
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
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
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
        if let posterUrl = movie.posterPath {
            print(posterUrl)
            if let url = URL(string: "\(ApiConstant.BASE_IMAGE_URL.rawValue)\(posterUrl)") {
                print(url.description)
                self.imageSmall.af.setImage(withURL: url, completion:  { data in
                    self.imageSmall.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                })
            }
        }
    }
}
