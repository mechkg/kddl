module KDDL.CommandLine.Public

where

import KDDL.Core
import KDDL.CommandLine.Private
import Options.Applicative

parseJob :: IO Job
parseJob = execParser commandLineParser

