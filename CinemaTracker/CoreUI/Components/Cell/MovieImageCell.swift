//
//  MovieImageCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit
import SnapKit

class MovieImageCell: UICollectionViewCell {
    
    private lazy var largeImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.isHidden = true
        return image
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = AppTheme.shared.colors.secondary
        indicator.startAnimating()
        return indicator
    }()
    
    
    static let identifier = "movie_image_cell"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(largeImage)
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        largeImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func saveMovie(movie:MovieModel) {
        if let posterUrl = movie.posterPath {
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
