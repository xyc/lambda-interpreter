# http://stackoverflow.com/questions/175739/is-there-a-built-in-way-in-javascript-to-check-if-a-string-is-a-valid-number
isNumber = (x) -> !isNaN(x)
isList = (x) -> Array.isArray(x)

calc = (exp) ->
  if isNumber exp
    return exp
  if isList exp
    [op, e1, e2] = exp
    v1 = calc e1
    v2 = calc e2
    switch op
      when '+' then return v1 + v2
      when '-' then return v1 - v2
      when '*' then return v1 * v2
      when '/' then return v1 / v2

# console.log calc ['+', 1, 2]
# console.log calc calc ['+', 1, 2]
# console.log calc ['*', 2, 3]
# console.log calc ['*', ['+', 1, 2], ['+', 3, 4]]

module.exports = calc
