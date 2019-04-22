module Program
  ( T
  , parse
  , fromString
  , toString
  , exec
  ) where

import qualified Dictionary
import Parser hiding (T)
import Prelude hiding (fail, return)
import qualified Statement

newtype T =
  Program [Statement.T]
  deriving (Show)

instance Parse T where
  parse = iter Statement.parse >-> Program
  toString = show

exec (Program p) = Statement.exec p Dictionary.empty
