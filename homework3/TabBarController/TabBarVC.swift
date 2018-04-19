//
//  TabBarVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    private let accountVM: AccountVM
    private let listVM: ParticipantsVM
    
    init(accountVM: AccountVM, listVM: ParticipantsVM) {
        self.accountVM = accountVM
        self.listVM = listVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        self.tabBar.tintColor = UIColor(named: "academy")
        let accountVC = AccountVC(viewModel: accountVM)
        accountVC.tabBarItem = createTabBarItem(title: "Účet", iconName: "ic-account")
        let participantVC = ParticipantsVC(viewModel: listVM)
        participantVC.tabBarItem = createTabBarItem(title: "Seznam účastníků", iconName: "ic-list")
        viewControllers = [participantVC, accountVC]
    }
    
    func createTabBarItem(title: String, iconName: String) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(named: iconName), selectedImage: UIImage(named: iconName))
    }
}
