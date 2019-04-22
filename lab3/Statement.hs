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
import Prelude hiding (fail, read, repeat, return)

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
  | Repeat Statement -- ̈́'repeat' statement 'until' expr ';'
           Expr.T
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

repeat =
  accept "repeat" -# parse #- require "until" # Expr.parse #- require ";" >->
  build
  where
    build (s, e) = Repeat s e

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
exec (Repeat do' cond:stmts) dict input = exec (do' : next) dict input
  where
    next
      | Expr.value cond dict > 0 = Repeat do' cond : stmts
      | otherwise = stmts
exec (Read var:stmts) dict (input:inputs) =
  exec stmts (Dictionary.insert (var, input) dict) inputs
exec (Write expr:stmts) dict input =
  Expr.value expr dict : exec stmts dict input

show' :: T -> String
show' (Assignment var val) = show var ++ " := " ++ Expr.toString val ++ "\n"
show' Skip = "skip;\n"
show' (Begin stmts) = foldl (++) "begin\n" (map toString stmts) ++ "end\n"
show' (If cond then' else') =
  "if " ++
  Expr.toString cond ++
  " then\n" ++ toString then' ++ "else\n" ++ toString else'
show' (While cond do') =
  "while " ++ Expr.toString cond ++ " do\n" ++ toString do'
show' (Repeat do' cond) =
  "repeat\n" ++ toString do' ++ "until " ++ Expr.toString cond ++ "\n"
show' (Read var) = "read " ++ show var ++ ";\n"
show' (Write expr) = "write " ++ Expr.toString expr ++ ";\n"

instance Parse Statement where
  parse = assignment ! skip ! begin ! if' ! while ! repeat ! read ! write
  toString = show'
