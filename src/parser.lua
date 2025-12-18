local lpeg = require"lpeg"
local ast = require"ast"
local P, V, C, Ct, Cg, Cc = lpeg.P, lpeg.V, lpeg.C, lpeg.Ct, lpeg.Cg, lpeg.Cc

local loc = lpeg.locale()

local ws = loc.space


--[[
Base syntax:

  (<rulename> (<premise> ...)  (<conclusion>) )

  -- (init a b) <- triplet with rulename, premises a and conclusion a
  -- ((a) (b)) <- pair with premises a and conclusion b
     ($ "a+b") <- function that transform the input string into latex math notation $a+b$
)
]]



local tk = function (t)
	return ws^0 * P(t) * ws^0
end
local ID = C(loc.alpha^1) / ast.ident
local inline_math = tk"$\"" * C((1 - P"\"")^0) * P"\"" / ast.inline_math
local EOF = P(-1)

local grammar = {
	"start",
  start = ws^0 * V"rule" * EOF,
  list = tk"(" * Ct(V"expr" * (ws^1 * V"expr")^0) * tk")",
  expr = inline_math + ID + V"rule",
  premises = V"list" + Ct(V"expr"),
  rule = tk"(" * (Cg(V"rulename") * ws^1 + Cc(nil)) * V"premises" * ws^1 * Cg(V"expr") * tk")" / ast.rule,
  rulename = (inline_math + (P"#" * ID)),
}

local function parse(input)
  grammar = P(grammar)
  return grammar:match(input)
end

return {
 parse = parse
}


