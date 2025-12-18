local ezproof = require"ezproof"

function Meta(meta)
  meta["header-includes"] = meta["header-includes"] or {}

  table.insert(
    meta["header-includes"],
    pandoc.RawBlock("tex", [[
\usepackage{amsmath}
\usepackage{amsthm}
\usepackage{bussproofs}
]])
  )

  return meta
end

if FORMAT:match 'latex' then
  function CodeBlock(block)
    if block.classes[1] == "proof" then
      return convertToProof(block.text)
    end
  end
end


function convertToProof(text)
  return pandoc.RawBlock("tex", ezproof.generate(text))
end
