local Node = {}
Node.__index = Node

function Node:new()
  return setmetatable({parent = nil, children = {}}, Node)
end

function Node:add_child(child)
  self.children[#self.children + 1] = child
  child.parent = self
end

function Node:root()
  if self.parent then
    return self.parent:root()
  else
    return self
  end
end

function Node:last_child()
  return self.children[#self.children]
end

function Node:level()
  return (self.parent and self.parent:level() + 1) or 0
end

function Node:find(predicate_fn)
  if predicate_fn(self) then return self end

  for _, child in ipairs(self.children) do
    result = child:find(predicate_fn)
    if result then return result end
  end

  return nil
end

function Node:find_parent(predicate_fn)
  if predicate_fn(self) then
    return self
  elseif self.parent then
    return self.parent:find_parent(predicate_fn)
  else
    return nil
  end
end

return Node
