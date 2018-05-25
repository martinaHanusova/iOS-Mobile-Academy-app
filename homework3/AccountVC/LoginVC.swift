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
        content.didBackButtonClick = {
            [weak self] in
            self?.dismiss(animated: true)
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
        } else {
            displayAlert(handler: {}, buttonTitle: "OK", messageTitle: "Empty email or password")
        }
    }
    
    func displayAlert(handler: @escaping () -> Void, buttonTitle: String, messageTitle: String) {
        let alert = UIAlertController(title: messageTitle, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: {action in handler()}))
        (presentedViewController ?? self).present(alert, animated: true, completion: nil)
    }
    
}


