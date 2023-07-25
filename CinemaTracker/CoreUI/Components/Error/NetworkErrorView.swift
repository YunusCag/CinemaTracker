//
//  NetworkErrorView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.07.2023.
//

import UIKit
import SnapKit

final class NetworkErrorView: UIView {
    
    private lazy var errorImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = AppTheme.shared.colors.secondary
        image.image = UIImage(systemName: "exclamationmark.circle.fill")
        return image
    }()
    
    private lazy var labelTitle:AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .normal2,color: AppTheme.shared.colors.textPrimary)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonRefresh: UIButton = {
       let button = UIButton()
        button.backgroundColor = AppTheme.shared.colors.secondary
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        button.setTitle(LocalizableKeys.Common.errorButton.getLocalized(), for: .normal)
        button.setTitleColor(AppTheme.shared.colors.whiteColor, for: .normal)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(errorImage)
        addSubview(labelTitle)
        addSubview(buttonRefresh)
        
        errorImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(errorImage.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
        buttonRefresh.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
    }
    
    func saveMessage(message:String?) {
        labelTitle.text = message ?? LocalizableKeys.Common.errorText.getLocalized()
    }
    
    func saveTabGesture(gesture: UITapGestureRecognizer) {
        self.buttonRefresh.addGestureRecognizer(gesture)
    }
}
