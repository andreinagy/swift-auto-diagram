
LANGUAGE_SWIFT = {

  extension: 'swift',

  entities: {
    class: 'class',
    struct: 'struct',
    enum: 'enum',
  },
  interface: 'protocol',

  entityRegex: /(?<entityType>(class|struct|protocol|enum))\s+(?!(var|open|public|internal|fileprivate|private|func))(?<name>\w+)(?<genericPart>(<.*>)?)(?<inheritancePart>([^{]*)?)(?<contentsCodeString>{(?>[^{}]|\g<contentsCodeString>)*})/,
  extensionRegex: /extension\s+(?!(var|open|public|internal|fileprivate|private|func))(?<extendedEntityName>\w+)(?<protocols>(\s*:.+?)?)(?<generics>(\s+where\s+.+?)?)(?<contentsCodeString>{(?>[^{}]|\g<contentsCodeString>)*})/,
  methodRegex: /(?<otherKeywords>(override|open|public|internal|fileprivate|private|static|class|\s)*)\bfunc\s+(?<name>([^{]*))(?<methodBody>{(?>[^{}]|\g<methodBody>)*})/,
  initsRegex: /(?<otherKeywords>(override|open|public|internal|fileprivate|private|\s)+)(?<name>(init[^{]*))(?<methodBody>{(?>[^{}]|\g<methodBody>)*})/,
  protocolMethodsRegex: /((?<isStatic>static)\s+)?func\s+(?<name>((?!static|var|weak|unowned|func|init)[\S\s])+)/,
  protocolInitsRegex: /\binit\(((?!static|var|weak|unowned|func|init)[\S\s])+/,
  propertiesRegex: /(?<otherKeywords>(open|public|internal|fileprivate|private|static|class|struct|weak|unowned|\s)+)?(?<name>(\bvar|\blet)\s+(\w+)\s*((?!open|public|internal|fileprivate|private|static|class|struct|var|let|weak|unowned|@IBOutlet|@IBAction|@IBInspectable|@IBDesignable)[^{=])*)/,
  casesRegex: /case\s+(?<cases>[\w\,\s]+)/
}.freeze
