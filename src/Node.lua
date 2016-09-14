local node = {}
node.__index = node

function node:new()
  return setmetatable({parent = nil, children = {}}, node)
end

return node