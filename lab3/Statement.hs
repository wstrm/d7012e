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

write = accept "write" -# Expr.parse #- require ";" >-> Write

read = accept "read" -# word #- require ";" >-> Read

skip = accept "skip" #- require ";" >-> const Skip

while = accept "while" -# Expr.parse #- require "do" # parse >-> build
  where
    build (e, s) = While e s

if' =
  accept "if" -# Expr.parse #- require "then" # parse #- require "else" # parse >->
  build
  where
    build ((e, v0), v1) = If e v0 v1

begin = accept "begin" -# iter parse #- require "end" >-> Begin

exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]
exec (If cond thenStmts elseStmts:stmts) dict input =
  if Expr.value cond dict > 0
    then exec (thenStmts : stmts) dict input
    else exec (elseStmts : stmts) dict input

instance Parse Statement where
  parse = assignment ! skip ! begin ! if' ! while ! read ! write
  toString = error "Statement.toString not implemented"
