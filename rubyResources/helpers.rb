require_relative 'languages/swift.rb'

def entitiesFromFiles
  entities = []
  extensions = []

  $allSwiftFilePaths.each do |fileName|
    fileContents = File.open(fileName, 'r:UTF-8').read

    Logger.log.info 'Original contents of file ' + fileName + ':'
    Logger.log.info Logger.safeCodeContents(fileContents)

    cleanedFileContents = removeCommentsAndStringsInCodeString fileContents

    entities += createEntities cleanedFileContents
    extensions += allExtensions cleanedFileContents

    Logger.log.info 'Finished parsing contents of file ' + fileName + "\n"
  end

  Logger.log.info 'Starting parsing inherited entities'
  parseInheritedEntities entities
  Logger.log.info 'Finished parsing inherited entities'

  Logger.log.info 'Starting parsing extensions'
  entities += parseExtensions extensions, entities
  Logger.log.info 'Finished parsing extensions'

  entities
end

def removeCommentsAndStringsInCodeString(codeString)
  codeString.gsub! /".*"/, ''

  Logger.log.info 'Removed strings from the content. Updated contents:'
  Logger.log.info Logger.safeCodeContents(codeString)

  while codeString.include?(LANGUAGE_SWIFT[:multiCommentStart]) &&
        codeString.include?(LANGUAGE_SWIFT[:multiCommentEnd])
    codeString.gsub! LANGUAGE_SWIFT[:multiComment], CHAR_EMPTY
    Logger.log.info 'Removing multiline comments from the content.\
     Updated contents:'
    Logger.log.info Logger.safeCodeContents(codeString)
  end

  Logger.log.info 'Removed multiline comments from the content.\
   Updated contents:'
  Logger.log.info Logger.safeCodeContents(codeString)

  codeString.gsub! LANGUAGE_SWIFT[:lineComment], CHAR_EMPTY

  Logger.log.info 'Removed single line comments from the content.\
   Updated contents:'
  Logger.log.info Logger.safeCodeContents(codeString)

  codeString
end

def createEntities(codeString)
  allEntities(codeString).each do |entity|
    entity.methods =
      entity.typeString == LANGUAGE_SWIFT[:interface] ?
      (allProtocolMethods(entity.contentsCodeString) +
      allProtocolInits(entity.contentsCodeString)) :
      (allMethods(entity.contentsCodeString) +
      allInits(entity.contentsCodeString))

    entity.properties = allProperties entity.contentsCodeString
    entity.cases = allCases entity.contentsCodeString
  end
end

def allEntities(codeString)
  entities = []
  entityRegex = LANGUAGE_SWIFT[:entityRegex]

  codeString.scan(entityRegex) do
    matchData = Regexp.last_match

    entityType = matchData[REGEX[:entityType]]
    entityName = matchData[REGEX[:name]]

    inheritancePart = matchData[REGEX[:inheritancePart]]
    inheritancePart.delete! LANGUAGE_SWIFT[:inheritanceDelimiter]
    inheritancePart.gsub! REGEX[:whiteSpace], CHAR_EMPTY
    inheritedEntities = inheritancePart.split LANGUAGE_SWIFT[:inheritanceEnumerationDelimiter]

    contentsCodeString = matchData[REGEX[:contentsCodeString]][1...-1]

    startIndex = matchData.begin(0)
    contentsStartIndex = matchData.begin(REGEX[:contentsCodeString]) + 1
    contentsEndIndex = matchData.end(REGEX[:contentsCodeString]) - 1

    subEntities = allEntities contentsCodeString
    entities += subEntities

    subEntitiesContents = subEntities.map do |subEntity|
      contentsCodeString[(subEntity.startIndex)..(subEntity.contentsEndIndex)]
    end.each do |subEntityContents|
      contentsCodeString.gsub! subEntityContents, CHAR_EMPTY
    end

    newEntity = EntityType.new(entityType,
                               entityName,
                               inheritedEntities,
                               contentsCodeString,
                               startIndex,
                               contentsStartIndex,
                               contentsEndIndex)

    newEntity.containedEntities += subEntities

    entities << newEntity
  end

  entities
end

def allExtensions(codeString)
  extensions = []
  extensionRegex = LANGUAGE_SWIFT[:extensionRegex]

  codeString.scan(extensionRegex) do
    matchData = Regexp.last_match

    extendedEntityName = matchData[LANGUAGE_SWIFT[:matchExtensions]]

    protocols = matchData[LANGUAGE_SWIFT[:matchInterfaces]]
    protocols.delete! LANGUAGE_SWIFT[:inheritanceDelimiter]
    protocols.gsub! REGEX[:whiteSpace], CHAR_EMPTY
    protocols = protocols.split LANGUAGE_SWIFT[:inheritanceEnumerationDelimiter]

    contentsCodeString = matchData[REGEX[:contentsCodeString]][1...-1]

    extensions << EntityExtension.new(protocols, extendedEntityName, contentsCodeString)
  end

  extensions
end

def allMethods(codeString)
  methods = []
  methodRegex = LANGUAGE_SWIFT[:methodRegex]

  methodsStrings = []

  codeString.scan(methodRegex) do
    matchData = Regexp.last_match

    otherKeywords = matchData['otherKeywords'].gsub(/\s{2,}/, ' ').strip.split(' ')

    accessLevel = 'internal'
    type = 'instance'

    otherKeywords.each do |otherKeyword|
      if otherKeyword == 'open' ||
         otherKeyword == 'public' ||
         otherKeyword == 'internal' ||
         otherKeyword == 'fileprivate' ||
         otherKeyword == 'private'

        accessLevel = otherKeyword

      elsif otherKeyword == 'static' ||
            otherKeyword == 'class'

        type = 'type'

      end
    end

    methods << SwiftMethod.new(matchData['name'], type, accessLevel)
    methodsStrings << matchData[0]
  end

  methodsStrings.each do |methodString|
    codeString.gsub! methodString, ''
  end

  methods
end

def allInits(codeString)
  methods = []
  methodRegex = LANGUAGE_SWIFT[:initsRegex]

  methodsStrings = []

  codeString.scan(methodRegex) do
    matchData = Regexp.last_match

    otherKeywords = matchData['otherKeywords'].gsub(/\s{2,}/, CHAR_SPACE).strip.split(CHAR_SPACE)

    accessLevel = 'internal'
    type = 'instance'

    otherKeywords.each do |otherKeyword|
      next unless otherKeyword == 'open' ||
                  otherKeyword == 'public' ||
                  otherKeyword == 'internal' ||
                  otherKeyword == 'fileprivate' ||
                  otherKeyword == 'private'

      accessLevel = otherKeyword
    end

    methods << SwiftMethod.new(matchData['name'], type, accessLevel)
    methodsStrings << matchData[0]
  end

  methodsStrings.each do |methodString|
    codeString.gsub! methodString, ''
  end

  methods
end

def allProtocolMethods(codeString)
  methods = []
  methodRegex = LANGUAGE_SWIFT[:protocolMethodsRegex]

  methodsStrings = []

  codeString.scan(methodRegex) do
    matchData = Regexp.last_match

    type = matchData['isStatic'] == 'static' ? 'type' : 'instance'

    methods << SwiftMethod.new(matchData['name'].strip, type, 'internal')
    methodsStrings << matchData[0]
  end

  methodsStrings.each do |methodString|
    codeString.gsub! methodString, ''
  end

  methods
end

def allProtocolInits(codeString)
  methods = []
  methodRegex = LANGUAGE_SWIFT[:protocolInitsRegex]

  methodsStrings = []

  codeString.scan(methodRegex) do
    matchData = Regexp.last_match
    methods << SwiftMethod.new(matchData[0].strip, 'instance', 'internal')
    methodsStrings << matchData[0]
  end

  methodsStrings.each do |methodString|
    codeString.gsub! methodString, CHAR_EMPTY
  end

  methods
end

def allProperties(codeString)
  properties = []
  propertyRegex = LANGUAGE_SWIFT[:propertiesRegex]
  codeString.scan(propertyRegex) do
    matchData = Regexp.last_match

    accessLevel = 'internal'
    type = 'instance'

    if matchData['otherKeywords']
      otherKeywords = matchData['otherKeywords'].strip.split(' ')
      otherKeywords.each do |otherKeyword|
        if otherKeyword == 'open' ||
           otherKeyword == 'public' ||
           otherKeyword == 'internal' ||
           otherKeyword == 'fileprivate' ||
           otherKeyword == 'private'

          accessLevel = otherKeyword

        elsif otherKeyword == 'static' ||
              otherKeyword == 'class'

          type = 'type'

        end
      end
    end

    properties << SwiftProperty.new(matchData['name'], type, accessLevel)
  end

  properties
end

def allCases(codeString)
  cases = []
  caseRegex = LANGUAGE_SWIFT[:casesRegex]
  codeString.scan(caseRegex) do
    matchData = Regexp.last_match

    accessLevel = 'internal'
    type = 'instance'

    cases += matchData['cases'].strip.split(', ') if matchData['cases']
  end

  cases.map { |c| SwiftEnumCase.new(c) }
end

def parseInheritedEntities(entities)
  entities.each do |entity|
    entity.inheritedEntities.each_with_index do |inheritedEntity, index|
      willBreak = false
      for searchedEntity in entities
        next unless inheritedEntity == searchedEntity.name
        if searchedEntity.typeString == 'class'
          entity.superClass = searchedEntity
        elsif searchedEntity.typeString == 'protocol'
          entity.protocols << searchedEntity
        end

        willBreak = true
        break
      end

      break if willBreak

      newEntity = EntityType.new((index == 0 ? 'class' : 'protocol'), inheritedEntity, [], nil, nil, nil, nil)
      entities << newEntity
      if index == 0
        entity.superClass = newEntity
      else
        entity.protocols << newEntity
      end
    end
  end
end

def parseExtensions(extensions, entities)
  extensions.each do |extension|
    extension.methods = allMethods(extension.contentsCodeString) +
                        allInits(extension.contentsCodeString)

    extension.properties = allProperties extension.contentsCodeString

    willBreak = false
    entities.each do |entity|
      next unless extension.extendedEntityName == entity.name
      entity.extensions << extension
      willBreak = true
      break
    end

    unless willBreak
      newEntity = EntityType.new('class', extension.extendedEntityName, [], nil, nil, nil, nil)
      newEntity.extensions << extension
      entities << newEntity
    end

    extension.inheritedEntities.each do |inheritedEntity|
      willBreak = false
      entities.each do |entity|
        next unless inheritedEntity == entity.name
        extension.protocols << entity
        willBreak = true
        break
      end

      next if willBreak
      newEntity = EntityType.new('protocol', inheritedEntity, [], nil, nil, nil, nil)
      extension.protocols << newEntity
      entities << newEntity
    end
  end
end

def updateEntitiesJSONStringInScript(entitiesStrings, scriptFileName)
  # scriptTemplateString
  string = 'var entities = $entities '
  string.gsub! '$entities', entitiesStrings
  File.write scriptFileName, string
end

def openFile(fileName)
  system %(open "#{fileName}")
end
