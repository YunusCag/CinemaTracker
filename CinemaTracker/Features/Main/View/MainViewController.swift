//
//  MainViewController.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.06.2023.
//

import UIKit
import SnapKit

final class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    private lazy var homeVC: HomeViewController = HomeViewController()
    private lazy var favouriteVC: FavouriteViewController = FavouriteViewController()
    private lazy var settingsVC: SettingsViewController = SettingsViewController()
    
    private lazy var viewModel: MainViewModel = MainViewModel()
    /*
     private lazy var tabController: UITabBarController = {
     let tabBar = UITabBarController()
     tabBar.setViewControllers([homeVC, favouriteVC, settingsVC], animated: true)
     return tabBar
     }()
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        viewModel.onInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
        initTheme()
        navigationItem.backButtonTitle = Constant.StringParameter.EMPTY_STRING
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
    func setUpView() {
        let controllers = [homeVC, favouriteVC, settingsVC]
        let homeTabItem = UITabBarItem(
            title: LocalizableKeys.Home.tabItem.getLocalized(),
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )
        let favouriteTabItem = UITabBarItem(
            title: LocalizableKeys.Favourites.tabItem.getLocalized(),
            image: UIImage(systemName: "heart.fill"),
            tag: 1
        )
        let settingsTabItem = UITabBarItem(
            title: LocalizableKeys.Settings.tabItem.getLocalized(),
            image: UIImage(systemName: "gearshape.fill"),
            tag: 2
        )
        homeVC.tabBarItem = homeTabItem
        favouriteVC.tabBarItem = favouriteTabItem
        settingsVC.tabBarItem = settingsTabItem
        
        self.viewControllers = controllers
    }
    
    func initTheme() {
        let standartApperance = UITabBarAppearance()
        standartApperance.configureWithOpaqueBackground()
        standartApperance.backgroundColor = AppTheme.shared.colors.background.withAlphaComponent(0.4)
        
        
        self.tabBar.tintColor = AppTheme.shared.colors.secondary
        self.tabBar.unselectedItemTintColor = AppTheme.shared.colors.textPrimary
        self.tabBar.clipsToBounds = false
        self.tabBar.isTranslucent = true
        self.tabBar.standardAppearance = standartApperance
        self.tabBar.scrollEdgeAppearance = standartApperance
    }
    
}

