//
//  Utilities.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 19.09.2021.
//

import Foundation

class Utilities{
    static func isPasswordValid(_ password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
