//
//  PaginationLoadingCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit
import SnapKit

class PaginationCell: UICollectionViewCell {
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
    static let identifier = "loading_cell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
