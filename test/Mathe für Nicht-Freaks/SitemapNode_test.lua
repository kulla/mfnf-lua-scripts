SitemapNode = require("Mathe für Nicht-Freaks/SitemapNode")
Node = require("Node")

local TestSitemapNode = {}

function TestSitemapNode:test_inheritance()
  luaunit.assertIs(getmetatable(SitemapNode).__index, Node)
end

function TestSitemapNode:test_new()
  local node = SitemapNode:new("<link>", "<name>", 23, 42)

  luaunit.assertNotNil(node)
  luaunit.assertNil(node.parent)
  luaunit.assertEquals(node.children, {})
  luaunit.assertIs(getmetatable(node), SitemapNode)

  luaunit.assertEquals(node.weight, 23)
  luaunit.assertEquals(node.link, "<link>")
  luaunit.assertEquals(node.name, "<name>")
  luaunit.assertEquals(node.progress, 42)
end

return TestSitemapNode
