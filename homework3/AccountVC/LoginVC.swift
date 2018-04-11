//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    public var didLogin : ((AccountCredentials) -> Void)?
    
    override func loadView() {
        
        //super.loadView()
        let content = LoginView()
        content.displayTextFields = true
        content.didSubmit = {
            if content.isFormCompleted {
                content.isDisabled = true
            UserDefaults.standard.set(content.inputNameValue, forKey: "Person")
            let login = Login(content.inputNameValue!, content.inputPasswordValue!)
            let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/login")
            var urlRequest = URLRequest(url: url!)
                urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
                let encoder = JSONEncoder()
                let model = login
                let data = try? encoder.encode(model)
                
                urlRequest.httpBody = data
                
                let dataTask = URLSession.shared.dataTask(with: urlRequest ){ (data, response, error) in
                    
                    guard let data = data else { return }
           
                    let decoder = JSONDecoder()
                
                    do {
                       let model = try decoder.decode(AccountCredentials.self, from: data)
                        DispatchQueue.main.async {        
                             if let didLogin = self.didLogin {
                                    didLogin(model)
                            }
                            self.dismiss(animated: true)
                        }
                    } catch {
                        content.isDisabled = false
                    }
                    

                }
                
                DispatchQueue.global().async {
                    dataTask.resume()
                }
                
                
                
            // self.dismiss(animated: true)
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


