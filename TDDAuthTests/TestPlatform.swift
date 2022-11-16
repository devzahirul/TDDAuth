//
//  TestPlatform.swift
//  TDDAuthTests
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import Foundation
@testable import TDDAuth


class TestAuth: AuthProtocol {
    func login() {
        
    }
    
    func registration() {
        
    }
    
    func logout() {
        
    }
}

class TestPlatform: Platform {
    private static let sharedInstance = TestPlatform()
    private let authIns = TestAuth()
    static func shared() -> Platform {
        return sharedInstance
    }
    
    func auth() -> AuthProtocol {
        return authIns
    }
}
