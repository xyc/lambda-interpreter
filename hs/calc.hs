module Calc where

{-
To test in GHCi:

Prelude> :l Calc
[1 of 1] Compiling Calc             ( calc.hs, interpreted )
Ok, modules loaded: Calc.
*Calc> import Calc
*Calc Calc> calc (Add (Const 1) (Const 2))
3
-}

data Expr = Const Integer
            | Add Expr Expr
            | Minus Expr Expr
            | Mul Expr Expr
            | Div Expr Expr deriving Show

calc :: Expr -> Integer
calc (Const i) = i
calc (Add e1 e2) = calc e1 + calc e2
calc (Minus e1 e2) = calc e1 - calc e2
calc (Mul e1 e2) = calc e1 * calc e2
calc (Div e1 e2) = calc e1 `div` calc e2
