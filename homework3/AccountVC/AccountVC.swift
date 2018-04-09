//
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    
    lazy var content = createLoginView()
    lazy var contentDetail = BusinessCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "Person")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.subviews.forEach({view in view.removeFromSuperview()})
        if let value = UserDefaults.standard.value(forKey: "Person") {
            let model = ViewModel()
            model.loadData()
            if let person = model.findByName(name: value as! String) {
                contentDetail.content = person.toBusinessCardContent()
                view.addSubview(contentDetail)
                contentDetail.translatesAutoresizingMaskIntoConstraints = false
                contentDetail.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                contentDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                contentDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                contentDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                return
            }
        }
            view.addSubview(content)
            content.translatesAutoresizingMaskIntoConstraints = false
            content.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            content.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    func createLoginView() -> LoginView {
        let content = LoginView()
        content.displayTextFields = false
        content.didSubmit = {
            self.present(LoginVC(), animated: true)
        }
        return content
    }

}


