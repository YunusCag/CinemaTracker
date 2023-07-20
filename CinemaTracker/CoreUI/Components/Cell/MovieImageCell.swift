//
//  MovieImageCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit
import SnapKit
import AlamofireImage

class MovieImageCell: UICollectionViewCell {
    
    private lazy var largeImage: MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
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
        
        largeImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func saveMovie(movie:MovieModel) {
        largeImage.saveUrl(path: movie.posterPath)
    }
}
