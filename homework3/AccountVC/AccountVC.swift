//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit


class AccountVC: UIViewController {
    
    lazy var loginView = createLoginView()
    lazy var profileView = BusinessCardView()
    
    private var account: AccountCredentials?
    private var profileData: BusinessCardContent?
    
    override func viewWillAppear(_ animated: Bool) {
        view.subviews.forEach({view in view.removeFromSuperview()})
        
        if account == nil {
            showLoginView()
            return
        }
        if let profileData = profileData {
            showParticipantDetail(businessCardContent: profileData)
            return
        }
        
        let loadingView = LoadingView()
        loadingView.setup()
        loadingView.frame = view.frame
        
        var timer : Timer?
        timer = Timer.scheduledTimer(
        withTimeInterval: 0.2, repeats: false) { _ in
            self.view.addSubview(loadingView)
        }
        
        let model = ViewModel()
        model.findByAccountCredentials(account: account!, onSuccess: {
            self.profileData = $0
            self.showParticipantDetail(businessCardContent: $0)
            timer?.invalidate()
            timer = nil
            loadingView.removeFromSuperview()
        }, onError:{
            timer?.invalidate()
            timer = nil
            loadingView.removeFromSuperview()
            self.showLoginView()
            
        })
    }
    
    func showLoginView() {
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func showParticipantDetail(businessCardContent: BusinessCardContent) {
        profileView.content = businessCardContent
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func createLoginView() -> LoginView {
        let content = LoginView()
        content.displayTextFields = false
        content.didSubmit = {
            let loginVC = LoginVC()
            loginVC.didLogin = {self.account = $0}
            self.present(loginVC, animated: true)
        }
        return content
    }
}


