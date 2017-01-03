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

return SitemapNode
