//
//  SettingsViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: CoreViewController<SettingsViewModel> {
    
    private lazy var labelLanguage:AppLabel = AppLabel()
    private lazy var languageOptionList: SettingOptionList = {
        let option = SettingOptionList()
        option.saveOptions(options: [LocalizableKeys.Common.languageEnglish.getLocalized(),LocalizableKeys.Common.languageTurkish.getLocalized()])
        
        let language = self.viewModel.selectedLanguage
        switch(language) {
        case .english:
            option.saveSelectedIndex(selectedIndex: 0)
        case .turkish:
            option.saveSelectedIndex(selectedIndex: 1)
        }
        return option
    }()
    
    private lazy var labelRegion:AppLabel = AppLabel()
    private lazy var regionOptionList: SettingOptionList = {
        let option = SettingOptionList()
        option.saveOptions(options: [LocalizableKeys.Common.regionUSA.getLocalized(),LocalizableKeys.Common.regionTurkey.getLocalized()])
        let region = self.viewModel.selectedRegion
        switch(region){
        case .USA:
            option.saveSelectedIndex(selectedIndex: 0)
        case .Turkey:
            option.saveSelectedIndex(selectedIndex: 1)
        }
        return option
    }()
    
    private lazy var labelTheme:AppLabel = AppLabel()
    private lazy var themeOptionList: SettingOptionList = {
        let option = SettingOptionList()
        option.saveOptions(options: [LocalizableKeys.Common.darkTheme.getLocalized(),LocalizableKeys.Common.lightTheme.getLocalized()])
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
        view.addSubview(labelLanguage)
        view.addSubview(languageOptionList)
        view.addSubview(labelRegion)
        view.addSubview(regionOptionList)
        view.addSubview(labelTheme)
        view.addSubview(themeOptionList)
        
        labelLanguage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            make.left.equalToSuperview().inset(16)
        }
        languageOptionList.snp.makeConstraints { make in
            make.top.equalTo(labelLanguage.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(95)
        }
        
        labelRegion.snp.makeConstraints { make in
            make.top.equalTo(languageOptionList.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(16)
        }
        regionOptionList.snp.makeConstraints { make in
            make.top.equalTo(labelRegion.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(95)
        }
        
        labelTheme.snp.makeConstraints { make in
            make.top.equalTo(regionOptionList.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(16)
        }
        
        themeOptionList.snp.makeConstraints { make in
            make.top.equalTo(labelTheme.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(95)
        }
        
        labelLanguage.text = LocalizableKeys.Settings.languageChoice.getLocalized()
        labelRegion.text = LocalizableKeys.Settings.regionChoice.getLocalized()
        labelTheme.text = LocalizableKeys.Settings.themeChoice.getLocalized()
        
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
        labelLanguage.initStyle(typograph: .title,color: AppTheme.shared.colors.textPrimary)
        labelRegion.initStyle(typograph: .title,color: AppTheme.shared.colors.textPrimary)
        labelTheme.initStyle(typograph: .title,color: AppTheme.shared.colors.textPrimary)
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
