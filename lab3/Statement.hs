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

skip = accept "skip" #- require ";" >-> const Skip

begin = accept "begin" -# iter parse #- require "end" >-> Begin

if' =
  accept "if" -# Expr.parse #- require "then" # parse #- require "else" # parse >->
  build
  where
    build ((e, s0), s1) = If e s0 s1

while = accept "while" -# Expr.parse #- require "do" # parse >-> build
  where
    build (e, s) = While e s

read = accept "read" -# word #- require ";" >-> Read

write = accept "write" -# Expr.parse #- require ";" >-> Write

exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]
exec [] dict input = []
exec (Assignment var val:stmts) dict input =
  exec stmts (Dictionary.insert (var, Expr.value val dict) dict) input
exec (Skip:stmts) dict input = exec stmts dict input
exec (Begin stmt:stmts) dict input = exec (stmt ++ stmts) dict input
exec (If cond then' else':stmts) dict input =
  if Expr.value cond dict > 0
    then exec (then' : stmts) dict input
    else exec (else' : stmts) dict input
exec (While cond do':stmts) dict input
  | Expr.value cond dict > 0 = exec (do' : While cond do' : stmts) dict input
  | otherwise = exec stmts dict input
exec (Read var:stmts) dict (input:inputs) =
  exec stmts (Dictionary.insert (var, input) dict) inputs
exec (Write expr:stmts) dict input =
  Expr.value expr dict : exec stmts dict input

instance Parse Statement where
  parse = assignment ! skip ! begin ! if' ! while ! read ! write
  toString = error "Statement.toString not implemented"
