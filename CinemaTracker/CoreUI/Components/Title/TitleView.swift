//
//  TitleView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 10.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class TitleView: UIView {
    
    private lazy var labelTitle: AppLabel = AppLabel()
    private lazy var titleImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName:"chevron.right.circle.fill")
        image.tintColor = AppTheme.shared.colors.secondary
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        //image.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = true
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(titleImageView)
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.height.equalToSuperview()
        }
        titleImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    func setTitle(value: String) {
        labelTitle.text = value
    }
    
    func initStyle(typograph: Typography,color: UIColor = AppTheme.shared.colors.textPrimary) {
        labelTitle.initStyle(typograph: typograph, color: color)
    }
    
    func setTapEvent(gesture:UITapGestureRecognizer) {
        addGestureRecognizer(gesture)
    }
}
