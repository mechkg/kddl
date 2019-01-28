module KDDL.Parser.Public where

import KDDL.Parser.Private
import Text.Megaparsec
import KDDL.Core
import Data.Text
import Data.Bifunctor

parseKddl :: String -> Text -> Either String [StructDef]
parseKddl src input = first parseErrorPretty (parse kddlParser src input)
