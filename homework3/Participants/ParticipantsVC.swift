//
//  ParticipantsVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class ParticipantsVC: UINavigationController {
    
    convenience init(viewModel: ParticipantsVM) {
        self.init(rootViewController: ParticipantListVC(viewModel: viewModel))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor(named: "academy")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

