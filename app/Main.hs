module Main where

import KDDL.Core
import KDDL.CommandLine.Public
import KDDL.Parser.Public

import Control.Concurrent
import Data.List
import Data.Either

import Data.Text.Encoding
import qualified Data.ByteString as BS
import Data.ByteString.UTF8
import System.FilePath

parseFile :: String -> IO (Either String [StructDef])
parseFile path = do
  byteSource <- BS.readFile path
  let source = decodeUtf8 byteSource
  return $ parseKddl path source
  
combineParseResults :: [Either String [StructDef]] -> Either [String] [StructDef]
combineParseResults e = 
  case partitionEithers e of 
    ([], rights) -> Right $ concat rights
    (errors, _) -> Left errors

parseFiles :: [String] -> IO (Either [String] [StructDef])
parseFiles paths = fmap combineParseResults $ sequence $ map parseFile paths

main :: IO ()
main = do
    job <- parseJob
    parseResult <- parseFiles $ sources job
    case parseResult of
      Left errors -> putStrLn $ concat $ intersperse "\n" errors
      Right result -> BS.writeFile (outputPath job </> "test.test") (fromString $ out)
        where
          names = map structName result
          out = concat $ intersperse "\n" names
