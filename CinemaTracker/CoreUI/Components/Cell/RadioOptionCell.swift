//
//  RadioOptionCell.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 13.07.2023.
//

import UIKit

class RadioOptionCell: UICollectionViewCell {
    
    private lazy var labelTitle: AppLabel = {
       let label = AppLabel()
        label.initStyle(typograph: .normal2,color: AppTheme.shared.colors.textPrimary)
        return label
    }()
    
    private lazy var imageRadio: UIImageView = {
       let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        image.image = UIImage(systemName: "circle")
        image.tintColor = AppTheme.shared.colors.secondary
        return image
    }()
    
    static let identifier = "radio_option_cell"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(labelTitle)
        addSubview(imageRadio)
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(2)
            make.right.equalTo(imageRadio.snp.left).inset(2)
        }
        imageRadio.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(4)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
    
    func save(title:String,isSelected: Bool, isLastIndex:Bool) {
        self.labelTitle.text = title
        if isSelected {
            self.imageRadio.image = UIImage(systemName: "circle.inset.filled")
        }else {
            self.imageRadio.image = UIImage(systemName: "circle")
        }
        self.imageRadio.tintColor = AppTheme.shared.colors.secondary
        if !isLastIndex {
            layer.addBorder(edge: .bottom, color: AppTheme.shared.colors.dividerColor, thickness: 1)
        }
        
    }
}


extension CALayer {

func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case .top:
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
    case .bottom:
        border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
    case .left:
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
    case .right:
        border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
    default:
        break
    }
    border.backgroundColor = color.cgColor
    addSublayer(border)
    }
}
