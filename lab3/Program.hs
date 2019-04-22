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

show' :: T -> String
show' (Program stmts) = concatMap Statement.toString stmts

parse' :: Parser T
parse' = iter Statement.parse >-> Program

instance Parse T where
  parse = parse'
  toString = show'

exec :: T -> [Integer] -> [Integer]
exec (Program p) = Statement.exec p Dictionary.empty
