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
    private var model: ViewModel?
    private let loading = LoadingView()
    
    convenience init(person: Person, model: ViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.person = person
        self.model = model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loading.setup()
        loading.frame = view.frame
        view.addSubview(loading)

        model?.findById(id: (person?.id)!) {
            bussinessCardContent in self.didLoadData(content: bussinessCardContent)
        }
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLoadData(content: BusinessCardContent) {
        loading.removeFromSuperview()
        let businessCardView = BusinessCardView()
        businessCardView.frame = view.frame
        businessCardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(businessCardView)
        businessCardView.showsVerticalScrollIndicator = false
        businessCardView.content = content
    }
}
