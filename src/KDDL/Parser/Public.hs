module KDDL.Parser.Public where

import Text.Parsec
import KDDL.Parser.Private

parseKddl = parse kddlParser