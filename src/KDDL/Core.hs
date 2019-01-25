module KDDL.Core

where

data Language = Cxx | Scala | Haskell deriving (Show, Read)

data Generator = Types | Json deriving (Show, Read)

data Job = Job {
    outputPath :: String,    
    language :: Language,
    generators :: [Generator],
    sources :: [String]
} deriving Show


data FieldType = Int32 | String | Seq FieldType deriving Show
    
data FieldDef = FieldDef FieldType String deriving Show

data StructDef = StructDef String [FieldDef] deriving Show
