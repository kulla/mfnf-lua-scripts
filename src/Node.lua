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

function node:level()
  return (self.parent and self.parent:level() + 1) or 0
end

return node