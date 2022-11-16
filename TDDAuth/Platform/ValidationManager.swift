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
}
