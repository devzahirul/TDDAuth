//
//  Drivers.swift
//  TDDAuth
//
//  Created by Islam Md. Zahirul on 16/11/22.
//

import Foundation


protocol AuthProtocol {
    func login()
    func registration()
    func logout()
}

protocol Platform {
    static func shared() -> Platform
    func auth() -> AuthProtocol
}
