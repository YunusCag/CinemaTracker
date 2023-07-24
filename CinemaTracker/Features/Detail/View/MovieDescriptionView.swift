//
//  MovieDescriptionView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 20.07.2023.
//

import UIKit

final class MovieDescription: UIView {
    
    
    private lazy var labelOverview: AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .normal2,color: AppTheme.shared.colors.textPrimary)
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.textAlignment = .justified
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
        addSubview(labelOverview)
        labelOverview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    func save(overview:String) {
        labelOverview.text = overview
    }
}
