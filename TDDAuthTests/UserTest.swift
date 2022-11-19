//
//  UserTest.swift
//  TDDAuthTests
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import XCTest
@testable import TDDAuth

extension RegistrationRequestModel {
    static let empty = RegistrationRequestModel(name: "", email: "", password: "", userName: "")
    static let whenEmailEmpty = RegistrationRequestModel(name: "A", email: "", password: "B", userName: "C")
    static let whenInvalidEmail = RegistrationRequestModel(name: "A", email: "a@/.com", password: "B", userName: "C")
}




class UserTest: XCTestCase {

    func test_create_new_account() {
        UserManager.registration(platform: TestPlatform.shared(), registrationModel: .empty) {result in
            switch result {
            case .failure(let error): do {
                XCTAssertEqual(error, AppError.fieldCanNotEmpty)
            }
            case .success(let response): do {
                XCTAssertNil(response)
            }
            }
        }
    }
    
    func test_create_new_account_email_empty() {
        UserManager.registration(platform: TestPlatform.shared(), registrationModel: .whenEmailEmpty) {result in
            switch result {
            case .failure(let error): do {
                XCTAssertEqual(error, AppError.fieldCanNotEmpty)
            }
            case .success(let response): do {
                XCTAssertNil(response)
            }
            }
        }
    }
    
    
    func test_create_new_account_invalid_email() {
        UserManager.registration(platform: TestPlatform.shared(), registrationModel: .whenInvalidEmail) {result in
            switch result {
            case .failure(let error): do {
                XCTAssertEqual(error, AppError.invalidEmailAddress)
            }
            case .success(let response): do {
                XCTAssertNil(response)
            }
            }
        }
    }
 
    
    func testAppleAuth() {
        let appleAuthDriver = TestAppleAuthDriver()
        let socialAuth = SocialAuth(appleAuthDriver)
        
        socialAuth.handleSuccess = {state, error in
            XCTAssertEqual(state, .registerded)
        }
        
        
        socialAuth.registration()
        
    }
    
}





class TestAppleAuthDriver: SocialAuthDriver {
    func login() {
        delegate?.success(authState: .signedIn, authResponse: nil)
    }
    
    func registration() {
        delegate?.success(authState: .registerded, authResponse: nil)
    }
    
    func logout() {
        delegate?.success(authState: .signedout, authResponse: nil)
    }
    
    var delegate: AuthResponseDelegae?
    
    
}


struct User {}
struct UserProfile {}


protocol AuthManagerProtocol {
    func login(email: String, password: String)
    func registration(email: String, password: String, userName: String)
    func logout()
}


protocol HttpProtocol {
    func doRequest()
}



class cUserManager {
    static func createProfile() {}
    
    static func deleteProfile() {}
    
    static func updateProfile() {}
    
    static func makeSelectProfile() {}
    
}



class cAuthManager: AuthManagerProtocol {
    private(set) var http: HttpProtocol
    
    init(_ http: HttpProtocol) {
        self.http = http
    }
    
    func login(email: String, password: String) {
        
    }
    
    func logout() {
        
    }
    
    func registration(email: String, password: String, userName: String) {
        
    }
}



