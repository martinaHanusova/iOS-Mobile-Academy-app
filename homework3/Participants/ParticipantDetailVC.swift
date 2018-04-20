//
//  ParticipantDetailVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class ParticipantDetailVC: UIViewController {
    
    public var content: BusinessCardContent? {
        didSet {
            updateView()
        }
    }
    
    private let loadingView = LoadingView()
    
    lazy var businessCardView = createBusinessCardView()
    
    func updateView() {
        view.subviews.forEach({view in view.removeFromSuperview()})
        if let content = content {
            didLoadData(content: content)
        } else {
            loadingView.setup()
            loadingView.frame = self.view.frame
            self.view.addSubview(self.loadingView)
        }
    }
    
    func didLoadData(content: BusinessCardContent) {
        businessCardView.frame = view.frame
        view.addSubview(businessCardView)
        businessCardView.content = content
        
    }
    
    func createBusinessCardView() -> BusinessCardView {
        let businessCardView = BusinessCardView()
        businessCardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        businessCardView.showsVerticalScrollIndicator = false
        return businessCardView
        }
    }
