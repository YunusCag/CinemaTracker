//
//  VideoViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 21.07.2023.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper


final class VideoViewController: UIViewController, YTPlayerViewDelegate {
    
    private lazy var youtubePlayer: YTPlayerView = {
        let player = YTPlayerView()
        player.backgroundColor = AppTheme.shared.colors.background
        return player
    }()
    
    var video: MovieVideoModel? = nil
    
    
    deinit {
        self.youtubePlayer.stopVideo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.shared.colors.background
        view.layer.cornerRadius = 20
        view.addSubview(youtubePlayer)
        
        if let key = self.video?.key {
            self.youtubePlayer.load(withVideoId:key)
        }
       
        self.youtubePlayer.delegate = self
        
        self.youtubePlayer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
