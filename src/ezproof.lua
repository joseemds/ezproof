local parser = require "parser"
local ast = require "ast"


local gen_premises = function (premises)
	local str = ""
	for _, premise in ipairs(premises) do
		local tmp = string.format("\\AxiomC{%s}\n", ast.render(premise))
		str = str .. tmp
	end

	return str
	
end

local gen_conclusion = function (conclusion, n_premises)
	local infe = {"UnaryInf", "BinaryInf", "TrinaryInf", "QuaternaryInf", "QuinaryInf"}

	return string.format("\\%sC{%s}", infe[n_premises], ast.render(conclusion))
end


local gen_rulename = function (rulename)
   if rulename ~= nil then
    return string.format("\\RightLabel{%s}", ast.render(rulename))
   end
   return ""
end


local generate = function (input)
  local rule = parser.parse(input)
  local premises = gen_premises(rule.premises)
  local rulename = gen_rulename(rule.name)
  local conclusion = gen_conclusion(rule.conclusion, #rule.premises)
  local out = string.format([[
  \begin{prooftree}
  %s
  %s
  %s
  \end{prooftree}
  ]], premises, rulename, conclusion)

  return out
end


return {
	generate = generate
}
