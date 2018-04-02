//
//  ParticipantDetailVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class ParticipantDetailVC: UIViewController {
    
    private var person: Person?
    
    convenience init(person: Person) {
        self.init(nibName: nil, bundle: nil)
        self.person = person
    }

    override func loadView() {
 
        let businessCardView = BusinessCardView()
        businessCardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view = businessCardView
        businessCardView.showsVerticalScrollIndicator = false
                
        businessCardView.content = person?.toBusinessCardContent()

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
