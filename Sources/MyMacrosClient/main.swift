import MyMacros
import Foundation

@EnumTitle
enum Lançamento {
    case semente
}

@AddID
class ExampleID {
    var num: Int = 0
}

@AllPublished
class Example {
    var age: Int = 0
}
