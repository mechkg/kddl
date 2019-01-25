module KDDL.Parser.Private where

import Text.Parsec
import Text.Parsec.Token (LanguageDef)
import qualified Text.Parsec.Token as PT
import Text.Parsec.Char
import Text.Parsec.Language (emptyDef)

import KDDL.Core
import KDDL.CommandLine.Public
    
kddlDef :: LanguageDef st
kddlDef = emptyDef {
    PT.commentStart = "/*",
    PT.commentEnd = "*/",
    PT.commentLine = "//",
    PT.reservedNames = ["struct"],
    PT.identStart  = letter,
    PT.identLetter = alphaNum <|> char '_'
}

kddlLexer = PT.makeTokenParser kddlDef

identifier = PT.identifier kddlLexer
whiteSpace = PT.whiteSpace kddlLexer
semicolon = PT.semi kddlLexer
braces = PT.braces kddlLexer

typeInt32 = string "int32" *> return Int32
typeString = string "string" *> return String

fieldType = typeInt32 <|> typeString 

fieldDef = do 
    t <- fieldType
    whiteSpace
    n <- identifier
    semicolon
    return $ FieldDef t n
    
struct = do
    string "struct"
    whiteSpace
    name <- identifier
    fields <- braces $ many fieldDef
    return $ StructDef name fields

kddlParser = whiteSpace *> many struct

result = parse kddlParser "Kotak" "    struct MyStruct { int32 b1_23; }"