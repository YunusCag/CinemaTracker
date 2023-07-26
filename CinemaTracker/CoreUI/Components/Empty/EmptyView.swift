//
//  EmptyView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 26.07.2023.
//

import UIKit
import SnapKit

final class EmptyView: UIView {
    
    private lazy var emptyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "no_data.png")
        return image
    }()
    
    private lazy var labelTitle:AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .normal2,color: AppTheme.shared.colors.textPrimary)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.text = LocalizableKeys.Favourites.emptyListTitle.getLocalized()
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
        addSubview(emptyImage)
        addSubview(labelTitle)
        
        emptyImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(emptyImage.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
    }
}
