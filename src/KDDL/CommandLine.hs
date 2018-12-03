module KDDL.CommandLine

where

import KDDL.Core
import Options.Applicative

parser :: Parser String
parser = strOption (long "test" <> short 't' <> help "Test option")

parserInfo = info parser (progDesc "Very powerful program")

f = execParser parserInfo

-- -l cxx a.kddl b.kddl

parseJobs :: IO (Either String [Job])
parseJobs = pure $ Left "Not Impl"

