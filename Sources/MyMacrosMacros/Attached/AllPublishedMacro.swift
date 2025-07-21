//
//  File.swift
//  MyMacros
//
//  Created by Pedro Somensi on 19/07/25.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

public struct AllPublishedMacro: MemberAttributeMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        [AttributeSyntax(attributeName: IdentifierTypeSyntax(name: .identifier("Published")))]
    }
}
