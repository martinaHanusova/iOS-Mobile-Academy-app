//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var didLogin : ((AccountCredentials) -> Void)?
    
    override func loadView() {
        let content = LoginView()
        content.displayTextFields = true
        content.didSubmit = {
            if content.isFormCompleted {
                content.isDisabled = true
            let model = ViewModel()
                model.logIn(name: content.inputNameValue!, password: content.inputPasswordValue!, onSuccess: {
                    if let didLogin = self.didLogin {
                        didLogin($0)
                    }
                    self.dismiss(animated: true)
                }, onError: {
                     content.isDisabled = false
                })
            
            }
        }
        view = content
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


