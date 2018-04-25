//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var didLogin : ((String, String) -> Void)?
    let content = LoginView()
    
    override func loadView() {
        content.displayTextFields = true
        content.didSubmit = {
            [weak self] in
            self?.afterSubmit()
        }
        view = content
    }
    
    func reset() {
        content.isDisabled = false
    }
    
    func afterSubmit() {
        if content.isFormCompleted {
            content.isDisabled = true
            didLogin?(self.content.inputNameValue!, self.content.inputPasswordValue!)
        }
    }
    
}


