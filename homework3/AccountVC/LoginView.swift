//
//  LoginViewNew.swift
//  homework3
//
//  Created by Martina Hanusova on 01.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {
    
    private lazy var nameTextField = createNameTextField()
    private lazy var passwordTextField = createPasswordTextField()
    private lazy var loginButton = createButton()
    public var didSubmit: (() -> Void)?
    public var inputNameValue: String? {
        get {
            return nameTextField.text
        }
    }
    private lazy var clickHandler = createClickHandler()
    public var displayTextFields: Bool? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        if displayTextFields ?? false {
            stackView.addArrangedSubview(nameTextField)
            stackView.addArrangedSubview(passwordTextField)
        }
        let buttonContrainer = UIStackView()
        buttonContrainer.axis = .vertical
        buttonContrainer.alignment = .center
        buttonContrainer.distribution = .equalCentering
        buttonContrainer.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(buttonContrainer)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func createNameTextField() -> UITextField {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Vlož přihlašovací jméno"
        nameTextField.font = UIFont.systemFont(ofSize: 14)
        nameTextField.textAlignment = .center
        nameTextField.tintColor = UIColor(named: "academy")
        nameTextField.borderStyle = .roundedRect
        nameTextField.keyboardType = .asciiCapable
        nameTextField.becomeFirstResponder()
        nameTextField.returnKeyType = .next
        nameTextField.isSecureTextEntry = false
        nameTextField.delegate = self
        return nameTextField
    }
    
    private func createPasswordTextField() -> UITextField {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Heslo"
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.textAlignment = .center
        passwordTextField.tintColor = UIColor(named: "academy")
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.returnKeyType = .go
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        return passwordTextField
    }
    
    private func createButton() -> UIButton {
        let padding: CGFloat = 15.0
        let cortnerRadius: CGFloat = 5
        let loginButton = UIButton()
        loginButton.setTitle("Přihlásit", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .highlighted)
        loginButton.backgroundColor = UIColor(named: "academy")
        loginButton.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        loginButton.layer.cornerRadius = cortnerRadius
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(clickHandler, action: #selector(ClickHandler.click), for: .touchUpInside)
        return loginButton
    }
    
    private func createClickHandler() -> ClickHandler {
        return ClickHandler {
            if let didSubmit = self.didSubmit {
                didSubmit()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            if let didSubmit = self.didSubmit {
                didSubmit()
            }
        }
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
}
