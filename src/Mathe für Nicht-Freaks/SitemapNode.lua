Node = require("Node")

local SitemapNode = {}

-- SitemapNode shall inherit from Node
setmetatable(SitemapNode, { __index = Node })

return SitemapNode
