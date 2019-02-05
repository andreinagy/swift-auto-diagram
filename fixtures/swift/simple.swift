
enum SimpleEnum {
    case north
    case south
    case east
    case west

    func enumMethod() {

    }
}

struct SimpleStruct {
    let string: String
    let number: Int
}

struct GenericStruct<Bucketable> {
    var items = [Bucketable]()

    mutating func add(item: Bucketable) {
        items.append(item)
    }

    mutating func remove() {
        items = []
    }
}

class SimpleClass {
    let field: Double
    let field1: Double

    func method() -> String {

    }
}

protocol SimpleProtocol {
    var field: String { get set }
    func protocolMethod() -> String
}

protocol AnotherSimpleProtocol {
    var field: String { get set }
    func anotherProtocolMethod() -> String
}

struct ProtocolConformingStruct: SimpleProtocol {
    var field: String
    func protocolMethod() -> String {
        return field
    }
}

class InheritedClass: SimpleClass {
    let field3: Int

    func method() -> String {
        
    }

    func methodWithUndefinedReturn() -> SDKEntity {

    }
}

class MultipleProtocolConformingClass: 
SimpleProtocol, 
{
    let multipleProtocolField
}

class MultipleProtocolConformingClass: AnotherSimpleProtocol {
    func anotherSimpleProtocolExtensionMethod() {
        
    }
}

