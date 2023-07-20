//
//  MovieDetailViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 18.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class MovieDetailViewController: CoreViewController<MovieDetailViewModel> {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isHidden = true
        return scroll
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = AppTheme.shared.colors.secondary
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var largeImage: MovieImageView = {
        let image = MovieImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250))
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var detailTopView: DetailTopView = {
        let detail = DetailTopView(frame: CGRect(x: 0, y:largeImage.frame.maxY, width: view.frame.width, height: 200))
        return detail
    }()
    
    private lazy var detailOverview: MovieDescription = {
        let oveview = MovieDescription(frame: CGRect(x: 0, y: detailTopView.frame.maxY, width: view.frame.width, height: 100))
        return oveview
    }()
    
    private lazy var castListView: CastListView = {
        let list = CastListView(frame: CGRect(x: 0, y: detailOverview.frame.maxY + 12, width: view.frame.width, height: 225))
        return list
    }()
    
    private lazy var crewtListView: CrewtListView = {
        let list = CrewtListView(frame: CGRect(x: 0, y: castListView.frame.maxY + 12, width: view.frame.width, height: 225))
        return list
    }()
    
    
    var movie:MovieModel? = nil
    
    override func setUpView() {
        self.viewModel.movie = self.movie
        self.title = self.movie?.title ?? Constant.StringParameter.EMPTY_STRING
        
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.scrollView.addSubview(largeImage)
        self.scrollView.addSubview(detailTopView)
        self.scrollView.addSubview(detailOverview)
        
        
        let height = self.largeImage.frame.height + self.detailTopView.frame.height + self.detailOverview.frame.height + self.castListView.frame.height + self.crewtListView.frame.height + 80
        self.scrollView.contentSize = CGSize(width: view.frame.width, height: height)

        
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
        self.navigationController?.navigationBar.tintColor = AppTheme.shared.colors.secondary
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.backButtonTitle = Constant.StringParameter.EMPTY_STRING
    }
    
    override func bindObservable() {
        viewModel.movieDetail.bind { detail in
            DispatchQueue.main.async {
                guard let movieDetail = detail else {
                    // TODO show empty state view
                    return
                }
                self.bindMovieDetail(movieDetail: movieDetail)
            }
        }
        
        viewModel.casts.bind { casts in
            DispatchQueue.main.async {
                if !casts.isEmpty {
                    self.scrollView.addSubview(self.castListView)
                    self.castListView.save(list: casts)
                }
            }
        }
        viewModel.crews.bind { crews in
            DispatchQueue.main.async {
                if !crews.isEmpty{
                    self.scrollView.addSubview(self.crewtListView)
                    self.crewtListView.save(list: crews)
                }
            }
        }
    }
    
    func bindMovieDetail(movieDetail: MovieDetailResponse) {
        self.scrollView.isHidden = false
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        
        self.largeImage.saveUrl(path: movieDetail.backdropPath)
        self.detailTopView.saveDetail(detail: movieDetail)
        
        if let overview = movieDetail.overview {
            self.detailOverview.save(overview: overview)
        }
        
    }
}
