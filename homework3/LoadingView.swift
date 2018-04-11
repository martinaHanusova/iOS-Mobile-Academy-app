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
         let loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loading.startAnimating()
        self.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}

