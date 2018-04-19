//
//  LocalAuthentication.swift
//  homework3
//
//  Created by Martina Hanusova on 18.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation
import LocalAuthentication

class LocalAuthentication: Authenticator {
    
    func check(onSucces: @escaping () -> Void, onError: @escaping () -> Void) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Prihlaseni ucastnika mobile academy"
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        onSucces()
                    } else {
                        onError()
                    }
                }
            } else {
                onError()
            }
        } else {
            onError()
        }
    }
}
