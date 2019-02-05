module KDDL.Generators.Cxx

where

import KDDL.Core
import Data.Text hiding (map, concat)

indent = "  "

genField :: FieldDef -> String
genField (FieldDef t name) = 
    ctype ++ " " ++ name where
        ctype = case t of 
          Int32 -> "int32_t"
          String -> "std::string"

genStruct :: StructDef -> Text
genStruct (StructDef name fields) = 
  pack $ "struct " ++ name ++ " {\n" ++ body ++ "\n};\n"
    where
      generatedFields = map genField fields
      body = concat $ map (\f -> indent ++ f ++ ";\n") generatedFields




{-

#include stuff

struct Kotak {
    int32_t kozon;
    std::string bozon;    
};


std::vector<Kotak> parsePgRow(row) {

}

-}