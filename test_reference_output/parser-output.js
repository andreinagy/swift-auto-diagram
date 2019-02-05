[{
  "id": 1,
  "typeString": "enum",
  "methods": [
    {
  "name": "method()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "cases": [
    {
  "name": "north case south case east case west"
}
  ],
  "name": "UnrelatedEnum"
},{
  "id": 2,
  "typeString": "struct",
  "properties": [
    {
  "name": "let string: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let number: Int",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "UnrelatedStruct"
},{
  "id": 3,
  "typeString": "struct",
  "properties": [
    {
  "name": "var array",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "add(item: TypeConstraint)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "UnrelatedGenericStruct"
},{
  "id": 4,
  "typeString": "class",
  "properties": [
    {
  "name": "let int: Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let double: Double",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "UnrelatedClass"
},{
  "id": 5,
  "typeString": "protocol",
  "properties": [
    {
  "name": "var field: String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "UnrelatedProtocol"
},{
  "id": 6,
  "typeString": "struct",
  "properties": [
    {
  "name": "let point: CGPoint",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let lineWidth: CGFloat",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "Constants"
},{
  "id": 7,
  "typeString": "class",
  "methods": [
    {
  "name": "method()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "NestedTypeClass",
  "containedEntities": [
    6
  ]
},{
  "id": 8,
  "typeString": "class",
  "properties": [
    {
  "name": "let field: Int",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "methodWithUndefinedReturn() -> SDKEntity",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "InheritedClass",
  "superClass": 17
},{
  "id": 9,
  "typeString": "protocol",
  "properties": [
    {
  "name": "var field: String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ProtocolBasic"
},{
  "id": 10,
  "typeString": "protocol",
  "properties": [
    {
  "name": "var field: String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ProtocolAdvanced"
},{
  "id": 11,
  "typeString": "struct",
  "properties": [
    {
  "name": "var field: String func method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    9
  ],
  "name": "ProtcolConformingStruct"
},{
  "id": 12,
  "typeString": "struct",
  "properties": [
    {
  "name": "var field: String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    9
  ],
  "name": "ProtocolConformingStruct"
},{
  "id": 13,
  "typeString": "class",
  "properties": [
    {
  "name": "var field: String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "method() -> String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    9
  ],
  "name": "SingleProtocolConformingClass"
},{
  "id": 14,
  "typeString": "class",
  "properties": [
    {
  "name": "let multipleProtocolField",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    9
  ],
  "name": "MultipleProtocolConformingClass"
},{
  "id": 15,
  "typeString": "class",
  "name": "ExtensionConformingProtocolClass",
  "extensions": [
    16
  ]
},{
  "id": 17,
  "typeString": "class",
  "name": "SimpleClass"
},{
  "id": 16,
  "typeString": "extension",
  "methods": [
    {
  "name": "method()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    9
  ]
}] 