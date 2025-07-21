//
//  File.swift
//  MyMacros
//
//  Created by Pedro Somensi on 19/07/25.
//

import Foundation

enum EnumInitError: CustomStringConvertible, Error {
    case onlyApplicableToEnum
    
    var description: String {
        switch self {
        case .onlyApplicableToEnum:
            "This macro can only be applied to a enum"
        }
    }
}
