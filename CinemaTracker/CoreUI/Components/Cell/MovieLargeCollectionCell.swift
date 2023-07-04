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
    
    private lazy var largeImage: UIImageView = {
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
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
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
    }
    
    
    func setMovieModel(movie:MovieModel) {
        labelName.text = movie.title ?? Constant.StringParameter.EMPTY_STRING
        if let posterUrl = movie.posterPath {
            print(posterUrl)
            if let url = URL(string: "\(ApiConstant.BASE_IMAGE_URL.rawValue)\(posterUrl)") {
                print(url.description)
                largeImage.af.setImage(withURL: url, completion:  { data in
                    self.largeImage.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                })
            }
        }
    }
}
