//
//  GenreCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 11.07.2023.
//

import Foundation
import UIKit
import SnapKit

class GenreCell: UICollectionViewCell {
    
    
    private lazy var labelTitle: AppLabel =  {
       let label = AppLabel()
        label.initStyle(typograph: .normal1,color: AppTheme.shared.colors.secondary)
        return label
    }()
    
    static let identifier = "genre_cell"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(labelTitle)
        
        labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        labelTitle.textAlignment = .center
        labelTitle.adjustsFontSizeToFitWidth = true
    }
    
    func save(name:String,isSelected: Bool) {
        if isSelected {
            labelTitle.initStyle(typograph: .normal1,color: AppTheme.shared.colors.whiteColor)
            backgroundColor = AppTheme.shared.colors.secondary
            layer.cornerRadius = 10
            layer.borderWidth = 0
            
        }else {
            labelTitle.initStyle(typograph: .normal2,color: AppTheme.shared.colors.secondary)
            backgroundColor = .clear
            layer.cornerRadius = 10
            layer.borderColor = AppTheme.shared.colors.secondary.cgColor
            layer.borderWidth = 2
        }
        labelTitle.text = name
    }
}
