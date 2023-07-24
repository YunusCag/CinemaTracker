//
//  FavouriteMovieCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 24.07.2023.
//

import UIKit
import SnapKit

class FavouriteMovieCell: UICollectionViewCell {
    
    
    static let identifier = "favourite_movie_cell"
    
    private lazy var movieImage: MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: 125, height: frame.height))
        image.round(with: .left,radius: 10)
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var labelTitle: AppLabel = {
       let label = AppLabel()
        label.numberOfLines = 2
        label.textAlignment = .justified
        label.lineBreakMode = .byTruncatingTail
        label.initStyle(typograph: .normal1,color: AppTheme.shared.colors.textPrimary)
        return label
    }()
    
    private lazy var labelDate: AppLabel = {
       let label = AppLabel()
        label.numberOfLines = 1
        label.textAlignment = .justified
        label.lineBreakMode = .byTruncatingTail
        label.initStyle(typograph: .normal2,color: AppTheme.shared.colors.secondary)
        return label
    }()
    
    private lazy var labelOverview: AppLabel = {
       let label = AppLabel()
        label.numberOfLines = 4
        label.textAlignment = .justified
        label.lineBreakMode = .byTruncatingTail
        label.initStyle(typograph: .small1,color: AppTheme.shared.colors.secondaryGray)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    
    private func createView() {
        addSubview(movieImage)
        addSubview(labelTitle)
        addSubview(labelDate)
        addSubview(labelOverview)
        
        backgroundColor = AppTheme.shared.colors.card
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
        clipsToBounds = false
        
        self.movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(125)
            make.height.equalToSuperview()
        }
        
        self.labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(self.movieImage.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
        self.labelDate.snp.makeConstraints { make in
            make.top.equalTo(self.labelTitle.snp.bottom).offset(4)
            make.left.equalTo(self.movieImage.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
        self.labelOverview.snp.makeConstraints { make in
            make.top.equalTo(self.labelDate.snp.bottom).offset(4)
            make.left.equalTo(self.movieImage.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
    }
    
    func save(movie:MovieModel) {
        self.movieImage.saveUrl(path: movie.posterPath)
        self.labelTitle.text = movie.title ?? Constant.StringParameter.EMPTY_STRING
        self.labelOverview.text = movie.overview ?? Constant.StringParameter.EMPTY_STRING
        self.labelDate.text = movie.releaseDate?.formatDateString() ?? Constant.StringParameter.EMPTY_STRING
    }
}


