//
//  TabBarVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.tintColor = UIColor(named: "academy")
        let accountVC = AccountVC()
        accountVC.tabBarItem = createTabBarItem(title: "Účet", iconName: "ic-account")
        let participantVC = ParticipantsVC()
        participantVC.tabBarItem = createTabBarItem(title: "Seznam účastníků", iconName: "ic-list")
        viewControllers = [participantVC, accountVC]
    }
    
    func createTabBarItem(title: String, iconName: String) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(named: iconName), selectedImage: UIImage(named: iconName))
    }
}
