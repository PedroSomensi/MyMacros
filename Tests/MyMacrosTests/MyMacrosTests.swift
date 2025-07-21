import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

import MyMacrosMacros

let testMacros: [String: Macro.Type] = [
    "stringify": StringifyMacro.self,
    "EnumTitle": EnumTitleMacro.self,
    "AddID": AddIDMacro.self,
    "AllPublished": AllPublishedMacro.self
]

final class MyMacrosTests: XCTestCase {
    
    func testMacro() throws {
        assertMacroExpansion(
            """
            #stringify(a + b)
            """,
            expandedSource: """
            (a + b, "a + b")
            """,
            macros: testMacros
        )
    }
    
    func testMacroWithStringLiteral() throws {
        assertMacroExpansion(
            #"""
            #stringify("Hello, \(name)")
            """#,
            expandedSource: #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#,
            macros: testMacros)
    }
    
    func testEnumTitleMacro() {
        assertMacroExpansion(
            """
            @EnumTitle
            enum Lançamento {
                case semente
            }
            """, expandedSource: """
            enum Lançamento {
                case semente
            
                var title: String {
                    switch self {
                    case .semente:
                        return "Semente"
                    }
                }
            }
            """, macros: testMacros)
    }
    
    func testExpansion() {
        assertMacroExpansion(
                """
                @AddID
                struct User {}
                """,
                expandedSource: """
                struct User {
                
                    let id: UUID = UUID()
                }
                
                extension User: Equatable {
                    public static func == (lhs: User, rhs: User) -> Bool {
                        return lhs.id == rhs.id
                    }
                }
                """,
                macros: testMacros)
    }
    
    
    func testExpansionAllPublishedMacri() {
        assertMacroExpansion(
                """
                @AllPublished
                class Example {
                    var age: Int = 0
                }
                """,
                expandedSource: """
                class Example {
                    @Published
                    var age: Int = 0
                }
                """,
                macros: testMacros)
    }
    
}

