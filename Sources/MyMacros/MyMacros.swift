// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "MyMacrosMacros", type: "StringifyMacro")

@attached(member, names: named(title))
public macro EnumTitle() = #externalMacro(module: "MyMacrosMacros", type: "EnumTitleMacro")

@attached(memberAttribute)
macro AllPublished() = #externalMacro(module: "MyMacrosMacros", type: "AllPublishedMacro")

@attached(member, names: arbitrary)
@attached(extension, conformances: Equatable, names: named(==))
public macro AddID() = #externalMacro(module: "MyMacrosMacros", type: "AddIDMacro")
