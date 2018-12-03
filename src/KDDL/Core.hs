module KDDL.Core

where

data Generator = Cxx | Scala | Haskell deriving Show

data Job = Job {
    sources :: [String],
    generator :: Generator
} deriving Show
