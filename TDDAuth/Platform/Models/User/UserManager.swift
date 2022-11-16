//
//  UserManager.swift
//  TDDAuth
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import Foundation

class UserManager {
    static func login(platform: Platform, email: String, password: String, completion: @escaping(Result<String, AppError>) -> Void) {
        completion(.failure(.notFound))
    }
    
    static func registration(platform: Platform,  registrationModel: RegistrationRequestModel, completion: @escaping(Result<String, AppError>) -> Void) {
        
        let isAnyFieldempty = ValidationManager.checkUserRegitrationRequestModelIsEmpty(registrationModel)
        
        if isAnyFieldempty {
            completion(.failure(.fieldCanNotEmpty))
            return
        }
        
        completion(.failure(.notFound))
    }
}
