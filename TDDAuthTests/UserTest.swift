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
    static let userA = RegistrationRequestModel(name: "A", email: "aA@gmail.com", password: "B", userName: "C")
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
    
    func test_create_new_account_without_field_empty() {
        UserManager.registration(platform: TestPlatform.shared(), registrationModel: .userA) {result in
            switch result {
            case .failure(let error): do {
                XCTAssertEqual(error, AppError.notFound)
            }
            case .success(let response): do {
                XCTAssertNil(response)
            }
            }
        }
    }
    
}
