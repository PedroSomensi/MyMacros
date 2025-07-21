//
//  File.swift
//  MyMacros
//
//  Created by Pedro Somensi on 19/07/25.
//

import Foundation

enum StructInitError: CustomStringConvertible, Error {
    case onlyApplicableToStructs
    
    var description: String {
        switch self {
        case .onlyApplicableToStructs:
            "This macro can only be applied to a struct"
        }
    }
}
