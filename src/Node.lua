local node = {}
node.__index = node

function node:new()
  return setmetatable({parent = nil, children = {}}, node)
end

function node:add_child(child)
  self.children[#self.children + 1] = child
  child.parent = self
  child.index  = #self.children
end

function node:last_child()
  return self.children[#self.children]
end

return node