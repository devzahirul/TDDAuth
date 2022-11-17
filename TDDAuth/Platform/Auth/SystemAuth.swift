//
//  AppleAuth.swift
//  TDDAuth
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import Foundation
import AuthenticationServices



protocol AuthResponseDelegae {
    func success()
    func failed()
}


protocol AuthDriver: AuthProtocol {
    var delegate: AuthResponseDelegae? { set get }
  
}



class AppleAuthDriver: NSObject, AuthDriver {
    var delegate: AuthResponseDelegae?
    
    func login() {
        
    }
    
    func registration() {
        
    }
    
    func logout() {
        
    }
    
    func performRequest() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        //authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}


extension AppleAuthDriver: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
           
            //self.saveUserInKeychain(userIdentifier)
            
           // self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            
            DispatchQueue.main.async {
                //self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
}




class SystemAuth: NSObject, AuthProtocol, AuthResponseDelegae {
    
    private(set) var driver: AuthDriver
    
    init(_ driver: AuthDriver) {
        
        self.driver = driver
        super.init()
        self.driver.delegate = self
    }
    
    
    func success() {
        // if success
    }
    
    func failed() {
        // if failed
    }
    
    func login() {
        
        driver.login()
    }
    
    func registration() {
        driver.registration()
    }
    
    func logout() {
        driver.logout()
    }
}


