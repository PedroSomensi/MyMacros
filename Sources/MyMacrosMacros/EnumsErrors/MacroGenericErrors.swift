//
//  File.swift
//  MyMacros
//
//  Created by Pedro Somensi on 19/07/25.
//

import Foundation

enum MacroGenericErrors: CustomStringConvertible, Error {
    case notApplicableToThisType(String)
    
    var description: String {
        switch self {
        case .notApplicableToThisType(let type):
            "This macro not suported for this type: \(type)"
        }
    }
}
