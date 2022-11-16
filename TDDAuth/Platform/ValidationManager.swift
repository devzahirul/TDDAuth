//
//  ValidationManager.swift
//  TDDAuth
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import Foundation

enum ValidationManager {
    static func checkUserRegitrationRequestModelIsEmpty(_ registrationRequestModel: RegistrationRequestModel) -> Bool {
        return registrationRequestModel.email == "" ||
        registrationRequestModel.password == "" ||
        registrationRequestModel.userName == "" ||
        registrationRequestModel.name == ""
    }
    
    /// Email Validation
    static func checkIsValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
}
