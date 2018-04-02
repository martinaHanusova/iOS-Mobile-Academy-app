//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    override func loadView() {
        
        //super.loadView()
        let content = LoginView()
        content.displayTextFields = true
        content.didSubmit = {
            UserDefaults.standard.set(content.inputNameValue, forKey: "Person")
            self.dismiss(animated: true)
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


