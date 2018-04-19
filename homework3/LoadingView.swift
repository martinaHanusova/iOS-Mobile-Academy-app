//
//  LoadingView.swift
//  homework3
//
//  Created by Martina Hanusova on 10.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    func setup() {
        self.subviews.forEach({view in view.removeFromSuperview()})
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            let loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            loading.startAnimating()
            loading.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(loading)
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
}

