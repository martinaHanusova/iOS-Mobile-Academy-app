//
//  LoginViewNew.swift
//  homework3
//
//  Created by Martina Hanusova on 01.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

public class LoginView: UIView, UITextFieldDelegate {
    
    private(set) lazy var nameTextField = createNameTextField()
    private(set) lazy var passwordTextField = createPasswordTextField()
    private(set) lazy var loginButton = createButton()
    private(set) lazy var backButton = createButtonBack()
    public var didSubmit: (() -> Void)?
    public var didBackButtonClick: (() -> Void)?
    public var inputNameValue: String? {
        get {
            return nameTextField.text
        }
    }
    public var inputPasswordValue: String? {
        get {
            return passwordTextField.text
        }
    }
    public var isFormCompleted: Bool {
        get {
            if inputNameValue == nil || inputNameValue == "" {
                return false
            }
            if inputPasswordValue == nil || inputPasswordValue == "" {
                return false
            }
            return true
        }
    }
    public var isDisabled: Bool = false {
        didSet {
                nameTextField.isEnabled = !isDisabled
                passwordTextField.isEnabled = !isDisabled
                loginButton.isEnabled = !isDisabled
        }
    }
    private lazy var clickHandler = createClickHandler()
    public var displayTextFields: Bool? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        self.backgroundColor = .white
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        if displayTextFields ?? false {
            let buttonBackContrainer = UIStackView()
            buttonBackContrainer.axis = .vertical
            buttonBackContrainer.alignment = .center
            buttonBackContrainer.distribution = .equalCentering
            buttonBackContrainer.addArrangedSubview(backButton)
            stackView.addArrangedSubview(buttonBackContrainer)
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
        nameTextField.keyboardType = .emailAddress
        nameTextField.autocapitalizationType = .none
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
    
    private func createButtonBack() -> UIButton {
        let padding: CGFloat = 15.0
        let cortnerRadius: CGFloat = 5
        let buttonBack = UIButton()
        buttonBack.setTitle("Zpět", for: .normal)
        buttonBack.setTitleColor(.white, for: .normal)
        buttonBack.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .highlighted)
        buttonBack.backgroundColor = UIColor(named: "academy")
        buttonBack.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        buttonBack.layer.cornerRadius = cortnerRadius
        buttonBack.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.addTarget(self, action: #selector(LoginView.backButtonClick), for: .touchUpInside)
        return buttonBack
    }
    
    private func createClickHandler() -> ClickHandler {
        return ClickHandler {
            if let didSubmit = self.didSubmit {
                didSubmit()
            }
        }
    }
    
    @objc public func backButtonClick() {
        if let didBackButtonClick = self.didBackButtonClick {
            didBackButtonClick()
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    
    public func clearPasswordTextfield() {
        passwordTextField.text = ""
    }
}
