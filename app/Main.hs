module Main where

import KDDL.Core
import KDDL.CommandLine.Public
import KDDL.Parser.Public

import Text.Parsec
import Control.Concurrent
import Data.List
import Data.Either

doStuff x = do
  sequence $ intersperse (threadDelay 500000) (replicate 10 $ putStrLn x)
  return ()

parseFile :: String -> IO (Either ParseError [StructDef])
parseFile path = parseKddl path <$> readFile path

combineParseResults :: [Either ParseError [StructDef]] -> Either [ParseError] [StructDef]
combineParseResults e = 
  case partitionEithers e of 
    ([], rights) -> Right $ concat rights
    (errors, _) -> Left errors

parseFiles :: [String] -> IO (Either [ParseError] [StructDef])
parseFiles paths = fmap combineParseResults $ sequence $ map parseFile paths

main :: IO ()
main = do
    job <- parseJob
    parseResult <- parseFiles $ sources job
    putStrLn $ show parseResult
