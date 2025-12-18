local M = {}

M.ident = function(id)
  return {tag = "id", name = id}
end

M.inline_math = function(text)
  return {
    tag = "math",
    latex = "$" .. text .. "$"
  }
end

M.rule = function (rulename, premises, conclusion)
    return {
      tag = "rule",
      name = rulename,
      premises = premises,
      conclusion = conclusion,
    }
end

local function render(node)
  if node.tag == "id" then
    return node.name

  elseif node.tag == "math" then
    return node.latex

  elseif node.tag == "rule" then
    local premises_tex = {}
    for _, p in ipairs(node.premises) do
      table.insert(premises_tex, render(p))
    end

    local conclusion_tex = render(node.conclusion)

    return premises_tex, conclusion_tex

  else
    error("Unknown AST tag: " .. tostring(node.tag))
  end
end


M.render = render

return M

