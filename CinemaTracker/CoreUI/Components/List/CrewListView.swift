//
//  CrewListView.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 20.07.2023.
//

import UIKit
import SnapKit

final class CrewtListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var screenWidth: CGFloat = frame.width
    private lazy var screenHeight: CGFloat = frame.height
    
    
    private var labelTitle: AppLabel = {
        let label = AppLabel()
        label.initStyle(typograph: .subtitle,color: AppTheme.shared.colors.textPrimary)
        label.textAlignment = .left
        label.text = LocalizableKeys.MovieDetail.crew.getLocalized()
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CastCrewCell.self, forCellWithReuseIdentifier: CastCrewCell.identifier)
        return collectionView
    }()
    
    
    private var crews:[CrewModel] = []
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    private func createView() {
        addSubview(labelTitle)
        addSubview(collectionView)
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    
    func save(list:[CrewModel]) {
        self.crews = list
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.crews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCrewCell.identifier, for: indexPath) as! CastCrewCell
        let cast = self.crews[indexPath.row]
        
        cell.save(
            profilePath: cast.profilePath,
            name: cast.name ?? Constant.StringParameter.EMPTY_STRING,
            description: cast.job ?? Constant.StringParameter.EMPTY_STRING
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
}

