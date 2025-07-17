//
//  EnumTitleMacro.swift
//  MyMacros
//
//  Created by Pedro Somensi on 17/07/25.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

public struct EnumTitleMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        // only used to enums
        guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
            throw EnumInitError.onlyApplicableToEnum
        }
        
        let members = enumDecl.memberBlock.members
        let caseDecl = members.compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
        let cases = caseDecl.compactMap { $0.elements.first?.identifier.text }
        
        var title = """
        var title: String {
            switch self {
        """
        
        for titleCase in cases {
            title += "case .\(titleCase):"
            title += "return \"\(titleCase.capitalized)\""
        }
        
        title += """
            }
        }
        """
        
        return [DeclSyntax(stringLiteral: title)]
    }
    
}

enum EnumInitError: CustomStringConvertible, Error {
    case onlyApplicableToEnum
    
    var description: String {
        switch self {
        case .onlyApplicableToEnum:
            "This macro can only be applied to a enum"
        }
    }
}
