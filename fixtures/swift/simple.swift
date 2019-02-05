
// Types that are not defined in the source code.
extension String {
	func method()
}

// Simple types definitions
enum UnrelatedEnum {
    case north
    case south
    case east
    case west

    func method() {

    }
}

struct UnrelatedStruct {
    let string: String
    let number: Int
}

struct UnrelatedGenericStruct<TypeConstraint> {
    var array = [TypeConstraint]()

    mutating func add(item: TypeConstraint) {
        array.append(item)
    }
}

class UnrelatedClass {
    let int: Int
    let double: Double

    func method() -> String {

    }
}

protocol UnrelatedProtocol {
    var field: String { get set }
    func method() -> String
}

// Nested types
class NestedTypeClass {
	struct Constants {
		let point: CGPoint
		let lineWidth: CGFloat
	}
	// commit 2b94196 doesn't detect field.
	field: String
	func method() {
	
	}
}

// Inheritance
class InheritedClass: SimpleClass {
    let field: Int

    func method() -> String {
        
    }

    func methodWithUndefinedReturn() -> SDKEntity {

    }
}

// Protocols conformance
// commit 2b94196 shows field and func on the same line
protocol ProtocolBasic {
    var field: String { get set }
    func method() -> String
}

protocol ProtocolAdvanced {
    var field: String { get set }
    func method() -> String
}

struct ProtcolConformingStruct: ProtocolBasic {
	var field: String
    func method() -> String
}

struct ProtocolConformingStruct: ProtocolBasic {
    var field: String
    func method() -> String {
        return field
    }
}

class SingleProtocolConformingClass: ProtocolBasic {
	var field: String
	func method() -> String {
	
	}
}

// commit 2b94196 shows conformance only to ProtocolBasic
class MultipleProtocolConformingClass: ProtocolBasic, ProtocolAdvanced {
    let multipleProtocolField
}

class ExtensionConformingProtocolClass {

}

// commit 2b94196 shows extension extension
extension ExtensionConformingProtocolClass: ProtocolBasic {
    func method() {
        
    }
}
