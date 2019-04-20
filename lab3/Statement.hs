module Statement
  ( T
  , parse
  , toString
  , fromString
  , exec
  ) where

import qualified Dictionary
import qualified Expr
import Parser hiding (T)
import Prelude hiding (fail, read, return)

type T = Statement

data Statement
  = Assignment String
               Expr.T
  | Skip -- 'skip' ';
  | Begin [Statement] -- 'begin' statements 'end'
  | If Expr.T -- 'if' expr 'then' statement 'else' statement
       Statement
       Statement
  | While Expr.T -- 'while' expr 'do' statement
          Statement
  | Read String -- 'read' variable ';
  | Write Expr.T -- 'write' expr ';'
  deriving (Show)

assignment = word #- accept ":=" # Expr.parse #- require ";" >-> build
  where
    build (v, e) = Assignment v e

write = accept "write" # Expr.parse #- require ";" >-> build
  where
    build (_, e) = Write e

read = (accept "read" -# word) #- require ";" >-> build
  where
    build = Read

exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]
exec (If cond thenStmts elseStmts:stmts) dict input =
  if Expr.value cond dict > 0
    then exec (thenStmts : stmts) dict input
    else exec (elseStmts : stmts) dict input

instance Parse Statement where
  parse = error "Statement.parse not implemented"
  toString = error "Statement.toString not implemented"
