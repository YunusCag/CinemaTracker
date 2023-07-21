//
//  MovieImageView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 19.07.2023.
//

import Foundation
import UIKit
import SnapKit
import AlamofireImage

class MovieImageView: UIImageView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = AppTheme.shared.colors.secondary
        indicator.isHidden = true
        return indicator
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        addSubview(activityIndicator)
        
        self.activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func saveUrl(path:String?) {
        if let backdropPath = path {
            
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            if let url = URL(string: "\(ApiConstant.BASE_IMAGE_URL.rawValue)\(backdropPath)") {
                self.af.setImage(withURL: url,runImageTransitionIfCached:true,completion:  { data in
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    if data.error != nil {
                        self.image = UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(AppTheme.shared.colors.secondary)
                        return
                    }
                    self.image = data.value
                    
                })
            }
        }
    }
    
    func saveUrl(videoId:String?) {
        if let id = videoId {
            
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            if let url = URL(string: "http://img.youtube.com/vi/\(id)/default.jpg") {
                self.af.setImage(withURL: url,runImageTransitionIfCached:true,completion:  { data in
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    if data.error != nil {
                        self.image = UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(AppTheme.shared.colors.secondary)
                        return
                    }
                    self.image = data.value
                    
                })
            }
        }
    }
}
