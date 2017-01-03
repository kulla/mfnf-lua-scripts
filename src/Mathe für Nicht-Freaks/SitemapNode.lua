Node = require("Node")

local SitemapNode = {}
SitemapNode.__index = SitemapNode

-- SitemapNode shall inherit from Node
setmetatable(SitemapNode, { __index = Node })

function SitemapNode:new(link, name, weight, progress)
  local self = Node:new()

  self.weight   = weight
  self.link     = link
  self.name     = name
  self.progress = progress

  return setmetatable(self, SitemapNode)
end

function SitemapNode:add_node(node)
  local last_child = self.children[#self.children]

  if last_child and node.weight > last_child.weight then
    last_child:add_node(node)
  else
    self:add_child(node)
  end
end

return SitemapNode
