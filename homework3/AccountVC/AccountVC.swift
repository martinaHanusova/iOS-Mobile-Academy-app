//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit


class AccountVC: UIViewController {
    
    lazy var loginView = createLoginView()
    lazy var loginVC = LoginVC()
    lazy var profileView = BusinessCardView()
    private let loadingView = LoadingView()
    private var viewModel: AccountVM
    
    init(viewModel: AccountVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }
    
    func bindViewModel() {
        viewModel.needLogin = {
            if self.presentedViewController == self.loginVC {
                self.loginVC.reset()
            } else {
                self.showLoginView()
            }
        }
        viewModel.willDownloadProfile = {
            if self.presentedViewController == self.loginVC {
                self.loginVC.dismiss(animated: true)
            }
            self.showLoadingView()
        }
        viewModel.didDownloadProfile = {
            self.showParticipantDetail(businessCardContent: $0)
        }
        
        viewModel.needFillInCredentials = {
            self.loginVC.didLogin = {
                self.viewModel.loginFilled(name: $0, password: $1)
            }
            self.present(self.loginVC, animated: true)
        }
        
        
    }
    
    
    
    func showLoginView() {
        reset()
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func showParticipantDetail(businessCardContent: BusinessCardContent) {
        reset()
        profileView.content = businessCardContent
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func showLoadingView() {
        reset()
        loadingView.setup()
        loadingView.frame = view.frame
        view.addSubview(self.loadingView)
    }
    
    func createLoginView() -> LoginView {
        let content = LoginView()
        content.displayTextFields = false
        content.didSubmit = {
            self.viewModel.loginRequested()
        }
        return content
    }
    
    func reset() {
        view.subviews.forEach({view in view.removeFromSuperview()})
    }
}


