module Main where

import KDDL.CommandLine
import Control.Monad.Except

a :: ExceptT String IO Int
a = ExceptT $ pure $ Right 8

b :: ExceptT String IO Int
b = ExceptT $ pure $ Left "mjo"


main :: IO ()
main = (show <$> runExceptT result) >>= putStrLn
  where
    result = do
            x <- b
            y <- a
            return (x + y)
