{-# LANGUAGE OverloadedStrings #-}

module KDDL.Parser.Private where

import KDDL.Core

import Text.Megaparsec
import Text.Megaparsec.Char
import Data.Void
import Data.Text
import qualified Text.Megaparsec.Char.Lexer as L
import qualified Text.Megaparsec.Error as ME

type Parser = Parsec Void Text

type ParseError = ME.ParseError Char Void

sc :: Parser ()
sc = L.space space1 lineComment blockComment
    where
    lineComment  = L.skipLineComment "//"
    blockComment = L.skipBlockComment "/*" "*/"

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: String -> Parser ()
symbol s = (L.symbol sc $ pack s) *> pure ()

inCurlyBrackets :: Parser a -> Parser a
inCurlyBrackets = between (symbol "{") (symbol "}")

identifier :: Parser String
identifier = lexeme $ (:) <$> letterChar <*> many (alphaNumChar <|> char '_')

semicolon :: Parser ()
semicolon = symbol ";"

typeInt32 = symbol "int32" *> pure Int32
typeString = symbol "string" *> pure String

fieldType = typeInt32 <|> typeString

fieldDef = do 
    t <- fieldType    
    n <- identifier
    semicolon
    return $ FieldDef t n
    
structDef = do
    symbol "struct"    
    name <- identifier
    fields <- inCurlyBrackets $ many fieldDef
    return $ StructDef name fields

kddlParser = sc *> many structDef
