//
//  SettingOptionList.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 13.07.2023.
//

import UIKit

class SettingOptionList: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    private lazy var screenWidth: CGFloat = frame.width
    private lazy var screenHeight: CGFloat = frame.height
    
    private var options:[String] = []
    private var selectedIndex = 0
    
    var listener:((Int) -> Void)? = nil
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 95), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(RadioOptionCell.self, forCellWithReuseIdentifier: RadioOptionCell.identifier)
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(collectionView)
        backgroundColor = AppTheme.shared.colors.card
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
        clipsToBounds = false
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
        }
    }
    
    func saveOptions(options:[String]){
        self.options.removeAll(keepingCapacity: false)
        self.options.append(contentsOf: options)
        self.collectionView.reloadData()
    }
    func saveSelectedIndex(selectedIndex:Int) {
        self.selectedIndex = selectedIndex
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RadioOptionCell.identifier, for: indexPath) as! RadioOptionCell
        let option = self.options[indexPath.row]
        cell.save(title: option, isSelected: self.selectedIndex == indexPath.row, isLastIndex: indexPath.row == self.options.count - 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        collectionView.reloadData()
        self.listener?(self.selectedIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
