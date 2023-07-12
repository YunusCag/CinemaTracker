//
//  GenreListViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 12.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class GenreListViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var genreList: [GenreModel] = []
    var selectedGenreIndex = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)

        return collectionView
    }()
    
    var onClickListener :((Int) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.shared.colors.background.withAlphaComponent(0.2)
        createView()
    }
    
    private func createView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        self.collectionView.scrollToItem(at: IndexPath(row: selectedGenreIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedGenreIndex = indexPath.row
        onClickListener?(self.selectedGenreIndex)
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genreList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:GenreCell.identifier , for: indexPath) as! GenreCell
        let isSelected = self.selectedGenreIndex == indexPath.row
        if indexPath.row == 0 {
            cell.save(name: LocalizableKeys.Common.all.getLocalized(), isSelected: isSelected)
        }else {
            let genre = self.genreList[indexPath.row - 1 ]
            cell.save(name: genre.name ?? Constant.StringParameter.EMPTY_STRING, isSelected: isSelected)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
}
