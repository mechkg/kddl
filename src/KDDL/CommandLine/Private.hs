module KDDL.CommandLine.Private

where
import Data.Char(toLower, toUpper)
import Text.Read(readMaybe)
import KDDL.Core
import Options.Applicative

makeReadable :: String -> String
makeReadable [] = []
makeReadable (h:t) = toUpper h : map toLower t

outputPathParser :: Parser String
outputPathParser = strOption $ 
                     long "output" 
                     <> short 'o' 
                     <> help "Output path" 
                     <> metavar "TARGET DIRECTORY"

languageParser :: Parser Language
languageParser = option parser $ 
                   long "language" 
                   <> short 'l' 
                   <> help "Target language" 
                   <> metavar "LANGUAGE"
                where parser = maybeReader $ readMaybe . makeReadable

generatorParser :: Parser Generator
generatorParser = option parser $ 
                    long "generate" 
                    <> short 'g' 
                    <> help "What code to generate" 
                    <> metavar "GENERATOR"
                 where parser = maybeReader $ readMaybe . makeReadable

inputFilesParser :: Parser String
inputFilesParser = argument str $
                    help "Input files" 
                    <> metavar "SOURCE FILE(S)"

jobsParser :: Parser Job
jobsParser = Job <$> outputPathParser <*> languageParser <*> some generatorParser <*> some inputFilesParser

commandLineParser = info jobsParser (progDesc "Generate source code from KDDL files")
