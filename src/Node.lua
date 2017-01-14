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

function Node:iter()
  -- Returns an iterator which returns the tree iterator for each child.
  function iter_child_iterators()
    local next_child, _, i = ipairs(self.children)
    local child = nil

    return function()
      i, child = next_child(self.children, i)

      if child then return child:iter() else return nil end
    end
  end

  local next_child_iterator = nil
  local child_iterator  = nil

  -- The actual iterator
  return function()
    if next_child_iterator then
      if child_iterator then
        local result = child_iterator()

        if result then
          return result
        else
          child_iterator = next_child_iterator()

          if child_iterator then return child_iterator() end
        end
      end
    else
      -- Iterator is called for the first time
      next_child_iterator = iter_child_iterators()
      child_iterator = next_child_iterator()
      return self
    end
  end
end

function Node:find(predicate_fn)
  for node in self:iter() do
    if predicate_fn(node) then return node end
  end
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
