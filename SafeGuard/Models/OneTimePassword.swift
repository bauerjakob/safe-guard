//
//  OneTimePassword.swift
//  SafeGuard
//
//  Created by Jakob Bauer on 08.02.24.
//

import Foundation
import SwiftOTP
import SwiftUI

class OneTimePassword : ObservableObject, Identifiable, Hashable {
    let id = UUID()
    private let totp: TOTP
    
    
    public var currentToken: String {
        return self.totp.generate(time: Date.now)!
    }
    
    @Published
    public var name: String;
    
    init(name: String, secret: String) {
        self.totp = TOTP(secret: base32DecodeToData(secret)!)!
        
        self.name = name
        
        self.updateCurrentToken()
        
        Thread {
            while true {
                self.updateCurrentToken()
                sleep(2000)
            }
        }
    }
    
    func updateCurrentToken() {
        // self.currentToken = self.totp.generate(time: Date.now)!
    }
    
    static func == (lhs: OneTimePassword, rhs: OneTimePassword) -> Bool {
            return lhs.id == rhs.id
        }

    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
}
