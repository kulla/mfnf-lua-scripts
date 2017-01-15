SitemapNode = require("Mathe für Nicht-Freaks/SitemapNode")
Node = require("Node")

local TestSitemapNode = {}

--- Creates self.root with the final tree:
--
-- root
--  |- node1
--      |- node2
--      |- node3
--  |- node4
--      |- node5
--          |- node6
--  |- node7
function TestSitemapNode:setUp()
  self.root = SitemapNode:new("<root>", "<root>", 0, 0)
  self.node1 = SitemapNode:new("1", "1", 2, 1)
  self.node2 = SitemapNode:new("2", "2", 3, 1)
  self.node3 = SitemapNode:new("3", "3", 3, 1)
  self.node4 = SitemapNode:new("4", "4", 1, 1)
  self.node5 = SitemapNode:new("5", "5", 2, 1)
  self.node6 = SitemapNode:new("6", "6", 3, 1)
  self.node7 = SitemapNode:new("7", "7", 1, 1)

  for _, node in ipairs({ self.node1, self.node2, self.node3, self.node4,
                       self.node5, self.node6, self.node7 }) do
    self.root:add_node(node)
  end
end

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

function TestSitemapNode:test_add_node()
  luaunit.assertNil(self.root.parent)
  luaunit.assertIs(self.node1.parent, self.root)
  luaunit.assertIs(self.node4.parent, self.root)
  luaunit.assertIs(self.node7.parent, self.root)
  luaunit.assertIs(self.node2.parent, self.node1)
  luaunit.assertIs(self.node3.parent, self.node1)
  luaunit.assertIs(self.node5.parent, self.node4)
  luaunit.assertIs(self.node5.parent, self.node4)

  luaunit.assertEquals(self.root.children,
                       { self.node1, self.node4, self.node7 })
  luaunit.assertEquals(self.node1.children, { self.node2, self.node3 })
  luaunit.assertEquals(self.node4.children, { self.node5 })
  luaunit.assertEquals(self.node5.children, { self.node6 })

  for _, node in pairs({ self.node2, self.node3, self.node6, self.node7 }) do
    luaunit.assertEquals(node.children, {})
  end
end

function TestSitemapNode:test_next()
  luaunit.assertIs(self.root:next_site(), self.node1)
  luaunit.assertIs(self.node1:next_site(), self.node2)
  luaunit.assertIs(self.node2:next_site(), self.node3)
  luaunit.assertIs(self.node3:next_site(), self.node4)
  luaunit.assertIs(self.node4:next_site(), self.node5)
  luaunit.assertIs(self.node5:next_site(), self.node6)
  luaunit.assertIs(self.node6:next_site(), self.node7)
  luaunit.assertIs(self.node7:next_site(), nil)
end

return TestSitemapNode
