SitemapNode = require("Mathe für Nicht-Freaks/SitemapNode")
Node = require("Node")

local TestSitemapNode = {}

function TestSitemapNode:test_inheritance()
  luaunit.assertIs(getmetatable(SitemapNode).__index, Node)
end

return TestSitemapNode
