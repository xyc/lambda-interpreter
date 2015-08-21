
isSymbol = (x) -> (typeof x is 'string' or x instanceof String) and x != 'λ'
isNumber = (x) -> !isNaN(x)
isList = (x) -> Array.isArray(x)

# use a function to represent env (can also be single association list, splay tree, etc...)
#env0 = {} # empty association list
env0 = () -> {} # the initial env

# extend env, returns a new env (extended by x:v), the original env is immutable
ext_env = (x, v, env) ->
  e = env() # new env
  e[x] = v
  return () -> e

# look up x in environment env
# env() is like {'x': 1}
lookup = (x, env) ->
  e = env()
  return (if x of e then e[x] else x) # if found return e[x] (v)

# Closure
# the function and the environment
Closure = (f, env) ->
  () -> [f, env]

###
symbol
function
invocation
number
algebraic expression
###

interp1 = (exp, env) ->
  if isSymbol exp
    return lookup exp, env   # this result might be arguments for outer expressions
  if isNumber exp
    return exp
  if isList exp

    if exp.length == 3 and exp[0] == 'λ' # match exp ['λ', [x], e]
      [lambda, [x], e] = exp #lambda = 'λ', [x] = arguments, e = expresion
      return Closure exp, env # Closure ['λ', [x], e], env # wrap function in a closure along with env

    # invocation
    if exp.length == 2
      [e1, e2] = exp
      v1 = interp1 e1, env # v1 is a closure
      v2 = interp1 e2, env

      # match v1 (unpack the closure (interp of a function is a closure, not evaluated))
      #[Closure [lambda (x) e]] = v1
      f1 = v1()[0]
      x = f1[1][0]
      e = f1[2] # not used
      env1 = v1()[1] # the env of the function (represented by e1)

      # interp e in the env (env is extended from e1's env (env1))
      return interp1 e, ext_env(x, v2, env1)

    # algebraic expression # note, this can also be interp as function invocation
    if exp.length == 3
      [op, e1, e2] = exp
      v1 = interp1 e1, env
      v2 = interp1 e2, env
      switch op
        when '+' then return v1 + v2
        when '-' then return v1 - v2
        when '*' then return v1 * v2
        when '/' then return v1 / v2

interp = (exp)->
  interp1 exp, env0

# console.log interp ['+', 1, 2]
# console.log interp ['*', 2, 3]
# console.log interp [['λ', ['x'], ['*', 2, 'x']], 3]

# () -> []
# add comma
# * -> '*'
# x -> 'x'
# console.log interp [[['λ', ['x'], ['λ', ['y'], ['*', 'x', 'y']]], 2], 3]

# TODO: support the other syntax
# (interp '(((lambda (x) (lambda (y) (* x y))) 2) 3))
#
###
{
  apply:
    apply:
      lambda:
        0: x
        1:
          lambda:
            0: y
            1:
              *:
                0: x
                1: y
      var: 2
    var: 3
}
###

module.exports = interp
