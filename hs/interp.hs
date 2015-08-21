module Interp where

{-
bound and free variable
-}

-- data Symbol

-- data Number = Integer

-- data Function =

data Expr = Const Integer
            | Add Expr Expr
            | Minus Expr Expr
            | Mul Expr Expr
            | Div Expr Expr
            | Symbol deriving Show

-- Data.Map
-- Env is assocation list
-- data Env

-- env0 :: Env
-- env0 =

-- lookup :: x -> Env ->

-- closure ::

-- interp' :: Expr -> Env -> Integer


-- interp :: Expr -> Interger
-- interp e = interp' e env0
