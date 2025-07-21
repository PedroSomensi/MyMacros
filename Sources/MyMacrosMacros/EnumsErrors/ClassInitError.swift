//
//  File.swift
//  MyMacros
//
//  Created by Pedro Somensi on 19/07/25.
//

import Foundation

enum ClassInitError: CustomStringConvertible, Error {
    case onlyApplicableToClasses
    
    var description: String {
        switch self {
        case .onlyApplicableToClasses:
            "This macro can only be applied to a class"
        }
    }
}
