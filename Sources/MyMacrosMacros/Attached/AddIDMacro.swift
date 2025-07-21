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

public struct AddIDMacro: MemberMacro, ExtensionMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        guard decl.as(StructDeclSyntax.self) != nil || decl.as(ClassDeclSyntax.self) != nil else {
            let typeName = String(describing: type(of: decl))
            throw MacroGenericErrors.notApplicableToThisType(typeName)
        }
        
        return [
            DeclSyntax(stringLiteral: "let id: UUID = UUID()")
        ]
    }
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        guard declaration.as(StructDeclSyntax.self) != nil || declaration.as(ClassDeclSyntax.self) != nil else {
            let typeName = String(describing: Swift.type(of: declaration))
            throw MacroGenericErrors.notApplicableToThisType(typeName)
        }

        let typeName = type.description.trimmingCharacters(in: .whitespacesAndNewlines)

        let ext = try ExtensionDeclSyntax(
            """
            extension \(raw: typeName): Equatable {
                public static func == (lhs: \(raw: typeName), rhs: \(raw: typeName)) -> Bool {
                    return lhs.id == rhs.id
                }
            }
            """
        )

        return [ext]
    }
    
}

