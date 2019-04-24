{-
   Lab H3: Parser Operators with Haskell
   Course: D7012E Declarative languages
   Student: William Wennerström <wenwil-5@student.ltu.se>
-}
module Expr
  ( Expr
  , T
  , parse
  , fromString
  , value
  , toString
  ) where

import qualified Dictionary
import Parser hiding (T)

{-
   An expression of type Expr is a representation of an arithmetic expression
   with integer constants and variables. A variable is a string of upper-
   and lower case letters. The following functions are exported

   parse :: Parser Expr
   fromString :: String -> Expr
   toString :: Expr -> String
   value :: Expr -> Dictionary.T String Int -> Int

   parse is a parser for expressions as defined by the module Parser.
   It is suitable for use in parsers for languages containing expressions
   as a sublanguage.

   fromString expects its argument to contain an expression and returns the
   corresponding Expr.

   toString converts an expression to a string without unneccessary
   parentheses and such that fromString (toString e) = e.

   value e env evaluates e in an environment env that is represented by a
   Dictionary.T Int.
-}
import Prelude hiding (fail, return)

data Expr
  = Num Integer
  | Var String
  | Add Expr
        Expr
  | Sub Expr
        Expr
  | Mul Expr
        Expr
  | Div Expr
        Expr
  deriving (Show)

type T = Expr

var, num, factor, term, expr :: Parser Expr
term', expr' :: Expr -> Parser Expr
var = word >-> Var

num = number >-> Num

mulOp = lit '*' >-> const Mul ! lit '/' >-> const Div

addOp = lit '+' >-> const Add ! lit '-' >-> const Sub

bldOp e (oper, e') = oper e e'

factor = num ! var ! lit '(' -# expr #- lit ')' ! err "illegal factor"

term' e = mulOp # factor >-> bldOp e #> term' ! return e

term = factor #> term'

expr' e = addOp # term >-> bldOp e #> expr' ! return e

expr = term #> expr'

parens cond str =
  if cond
    then "(" ++ str ++ ")"
    else str

shw :: Int -> Expr -> String
shw prec (Num n) = show n
shw prec (Var v) = v
shw prec (Add t u) = parens (prec > 5) (shw 5 t ++ "+" ++ shw 5 u)
shw prec (Sub t u) = parens (prec > 5) (shw 5 t ++ "-" ++ shw 6 u)
shw prec (Mul t u) = parens (prec > 6) (shw 6 t ++ "*" ++ shw 6 u)
shw prec (Div t u) = parens (prec > 6) (shw 6 t ++ "/" ++ shw 7 u)

value :: Expr -> Dictionary.T String Integer -> Integer
value (Num n) _ = n
value (Var k) dict =
  case Dictionary.lookup k dict of
    Just v -> v
    _ -> error ("undefined variable " ++ k)
value (Add t u) dict = value t dict + value u dict
value (Sub t u) dict = value t dict - value u dict
value (Mul t u) dict = value t dict * value u dict
value (Div t u) dict
  | u' == 0 = error "division by 0"
  | otherwise = t' `div` u'
  where
    t' = value t dict
    u' = value u dict

instance Parse Expr where
  parse = expr
  toString = shw 0
