//
//  MovieDetailViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 18.07.2023.
//

import Foundation
import UIKit
import SnapKit
import GoogleMobileAds

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
    
    private lazy var bannerView:GADBannerView = {
        let banner = GADBannerView(adSize: GADAdSize(size: CGSize(width: 320, height: 100), flags: 1))
        banner.frame = CGRect(x: (view.frame.width / 2 - 160), y: detailOverview.frame.maxY + 10, width: 320, height: 100)
        banner.adUnitID = Constant.AdmobUtil.bannerAdId
        banner.load(GADRequest())
        return banner
    }()
    
    
    private lazy var castListView: CastListView = {
        let list = CastListView(frame: CGRect(x: 0, y: bannerView.frame.maxY + 12, width: view.frame.width, height: 225))
        return list
    }()
    
    private lazy var crewtListView: CrewtListView = {
        let list = CrewtListView(frame: CGRect(x: 0, y: castListView.frame.maxY + 12, width: view.frame.width, height: 225))
        return list
    }()
    
    private lazy var videoListView: VideoListView = {
        let list = VideoListView(frame: CGRect(x: 0, y: crewtListView.frame.maxY + 12, width: view.frame.width, height: 225))
        return list
    }()
    
    
    var movie:MovieModel? = nil
    private var interstitial: GADInterstitialAd?
    
    
    override func setUpView() {
        if AdmobHelper.shared.checkShowInterstital() {
            interstitalRequest()
        }
        
        self.viewModel.movie = self.movie
        self.title = self.movie?.title ?? Constant.StringParameter.EMPTY_STRING
        
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        
        bannerView.rootViewController = self
        
        
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
        self.scrollView.addSubview(bannerView)
        
        
        let height = self.largeImage.frame.height + self.detailTopView.frame.height + self.detailOverview.frame.height + self.bannerView.frame.height + 80
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
                    let contentSize = self.scrollView.contentSize
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentSize.height + self.castListView.frame.height)
                    self.scrollView.addSubview(self.castListView)
                    self.castListView.save(list: casts)
                }
            }
        }
        viewModel.crews.bind { crews in
            DispatchQueue.main.async {
                if !crews.isEmpty{
                    let contentSize = self.scrollView.contentSize
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentSize.height + self.crewtListView.frame.height)
                    self.scrollView.addSubview(self.crewtListView)
                    self.crewtListView.save(list: crews)
                }
            }
        }
        
        viewModel.videoList.bind { videoList in
            DispatchQueue.main.async {
                if !videoList.isEmpty {
                    let contentSize = self.scrollView.contentSize
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentSize.height + self.videoListView.frame.height)
                    self.scrollView.addSubview(self.videoListView)
                    self.videoListView.save(list: videoList)
                    
                    self.videoListView.listener = {(video:MovieVideoModel) in
                        let controller = VideoViewController()
                        controller.video = video
                        controller.modalPresentationStyle = .pageSheet

                        if let sheet = controller.sheetPresentationController {
                            sheet.detents = [.custom { _ in
                                return 320
                            }]
                        }
                        self.present(controller, animated: true)
                    }
                }
            }
        }
        
        viewModel.isMovieLiked.bind { isLiked in
            DispatchQueue.main.async {
                var image = UIImage(systemName: "heart")
                if isLiked {
                    image = UIImage(systemName: "heart.fill")
                }
                let button = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.onLikeClicked))
                button.tintColor = AppTheme.shared.colors.secondary
                self.navigationItem.rightBarButtonItem = button
            }
        }
        
    }
    
    @objc func onLikeClicked() {
        if viewModel.isMovieLiked.value {
            viewModel.dislikeMovie()
        } else {
            viewModel.likeMovie()
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
    
    fileprivate func interstitalRequest() {
        let request = GADRequest()
        GADInterstitialAd.load(
            withAdUnitID: Constant.AdmobUtil.instertialAdId,
            request: request,
            completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                interstitial = ad
                self.interstitial?.present(fromRootViewController: self)
                interstitial = nil
            }
        )
    }
}
