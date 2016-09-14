local Node = {}
Node.__index = Node

function Node:new()
  return setmetatable({parent = nil, children = {}}, Node)
end

function Node:add_child(child)
  self.children[#self.children + 1] = child
  child.parent = self
  child.index  = #self.children
end

function Node:last_child()
  return self.children[#self.children]
end

function Node:level()
  return (self.parent and self.parent:level() + 1) or 0
end

return Node