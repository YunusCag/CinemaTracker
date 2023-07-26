//
//  SettingsViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import UIKit
import SnapKit
import GoogleMobileAds

final class SettingsViewController: CoreViewController<SettingsViewModel> {
    
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private lazy var bannerView:GADBannerView = {
        let banner = GADBannerView()
        banner.frame = CGRect(x: (view.frame.width / 2 - 160), y: 0, width: 320, height: 50)
        banner.adUnitID = Constant.AdmobUtil.bannerAdId
        banner.load(GADRequest())
        banner.backgroundColor = .clear
        return banner
    }()
    
    
    private lazy var languageOptionList: SettingOptionList = {
        let option = SettingOptionList(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 140))
        option.saveOptions(options: [LocalizableKeys.Common.languageEnglish.getLocalized(),LocalizableKeys.Common.languageTurkish.getLocalized()])
        option.saveTitle(title:LocalizableKeys.Settings.languageChoice.getLocalized())
        let language = self.viewModel.selectedLanguage
        switch(language) {
        case .english:
            option.saveSelectedIndex(selectedIndex: 0)
        case .turkish:
            option.saveSelectedIndex(selectedIndex: 1)
        }
        return option
    }()
    
    private lazy var regionOptionList: SettingOptionList = {
        let option = SettingOptionList(frame: CGRect(x: 0, y: languageOptionList.frame.maxY, width: view.frame.width, height: 140))
        option.saveOptions(options: [LocalizableKeys.Common.regionUSA.getLocalized(),LocalizableKeys.Common.regionTurkey.getLocalized()])
        option.saveTitle(title:LocalizableKeys.Settings.regionChoice.getLocalized())
        let region = self.viewModel.selectedRegion
        switch(region){
        case .USA:
            option.saveSelectedIndex(selectedIndex: 0)
        case .Turkey:
            option.saveSelectedIndex(selectedIndex: 1)
        }
        return option
    }()
    
    private lazy var themeOptionList: SettingOptionList = {
        let option = SettingOptionList(frame: CGRect(x: 0, y: regionOptionList.frame.maxY,width: view.frame.width, height: 140))
        option.saveOptions(options: [LocalizableKeys.Common.darkTheme.getLocalized(),LocalizableKeys.Common.lightTheme.getLocalized()])
        option.saveTitle(title:LocalizableKeys.Settings.themeChoice.getLocalized())
        let region = self.viewModel.selectedTheme
        switch(region){
        case .Dark:
            option.saveSelectedIndex(selectedIndex: 0)
        case .Light:
            option.saveSelectedIndex(selectedIndex: 1)
        }
        return option
    }()
    
    
    private var isSettingsChanged:Bool = false
    
    
    override func setUpView() {
        view.addSubview(scrollView)
        view.addSubview(bannerView)
        
        bannerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(50)
            
        }
        
        bannerView.rootViewController = self
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(bannerView.snp.top)
        }
        scrollView.addSubview(languageOptionList)
        scrollView.addSubview(regionOptionList)
        scrollView.addSubview(themeOptionList)
        
        let height = self.languageOptionList.frame.height + self.regionOptionList.frame.height + self.themeOptionList.frame.height + 80
        scrollView.contentSize = CGSize(width: view.frame.width, height: height)
        
        languageOptionList.listener = { index in
            var languageType = LanguageType.english
            switch(index) {
            case 0:
                languageType = LanguageType.english
            case 1:
                languageType = LanguageType.turkish
            default:
                languageType =  LanguageType.english
            }
            self.viewModel.changeLanguage(language: languageType)
            self.restartApp()
        }
        regionOptionList.listener = { index in
            self.isSettingsChanged = true
            var region = RegionType.USA
            switch(index) {
            case 0:
                region = RegionType.USA
            case 1:
                region = RegionType.Turkey
            default:
                region =  RegionType.USA
            }
            self.viewModel.changeRegion(region: region)
        }
        
        themeOptionList.listener = { index in
            var theme = ThemeType.Light
            
            switch(index) {
            case 0:
                theme = .Dark
            case 1:
                theme = .Light
            default:
                theme = .Light
            }
            self.viewModel.changeTheme(type: theme)
            self.restartApp()
        }
    }
    
    override func initTheme() {
        view.backgroundColor = AppTheme.shared.colors.background
    }
    
    override func bindObservable() {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isSettingsChanged {
            NotificationCenter.default.post(name: .settingsChange, object: nil)
            self.isSettingsChanged = false
        }
    }
    
    private func restartApp() {
        guard let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first else {
            return
        }
        let mainVC = UINavigationController(rootViewController: MainViewController())
        
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            window.rootViewController = mainVC
            window.makeKeyAndVisible()
        })
    }
}
