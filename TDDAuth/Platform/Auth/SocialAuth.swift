//
//  AppleAuth.swift
//  TDDAuth
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import Foundation
import AuthenticationServices


struct AuthResponse {
    let userIdentifier: String?
    let email: String?
    let name: String?
}

enum AuthState {
    case signedIn
    case signedout
    case registerded
}


protocol AuthResponseDelegae {
    func success(authState: AuthState, authResponse: AuthResponse?)
    func failed(authState: AuthState,  error: AppError?)
}


protocol SocialAuthDriver: AuthProtocol {
    var delegate: AuthResponseDelegae? { set get }
  
}



class AppleAuthDriver: NSObject, SocialAuthDriver {
    var delegate: AuthResponseDelegae?
    
    func login() {
        delegate?.success(authState: .signedIn, authResponse: nil)
    }
    
    func registration() {
        delegate?.success(authState: .registerded, authResponse: nil)
    }
    
    func logout() {
        delegate?.success(authState: .signedout, authResponse: nil)
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




class SocialAuth: NSObject, AuthProtocol, AuthResponseDelegae {
    
    var handleSuccess: ((AuthState, AuthResponse?) -> Void)?
    var handleFailed: ((AuthState, AppError?) -> Void)?
  
    func success(authState: AuthState, authResponse: AuthResponse?) {
        handleSuccess?(authState, authResponse)
    }
    
    func failed(authState: AuthState, error: AppError?) {
        handleFailed?(authState, error)
    }
    
    
    private(set) var driver: SocialAuthDriver
    
    init(_ driver: SocialAuthDriver) {
        
        self.driver = driver
        super.init()
        self.driver.delegate = self
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


