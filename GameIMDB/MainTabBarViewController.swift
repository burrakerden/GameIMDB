//
//  MainTabBarViewController.swift
//  deneme2222
//
//  Created by Burak Erden on 19.01.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    func setupUI() {
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: FavoriteViewController())
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart.fill")
        setViewControllers([vc1, vc2], animated: true)
        tabBar.tintColor = .black
    }
}



