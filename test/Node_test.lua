luaunit = require("luaunit")
Node = require("Node")

local TestNode = {}

function TestNode:setUp()
  self.root, self.node1, self.node2, self.node3 = Node:new(), Node:new(), Node:new(), Node:new()
  self.root:add_child(self.node1)
  self.root:add_child(self.node2)
  self.node2:add_child(self.node3)
end

function TestNode:test_new()
  local root = Node:new()

  luaunit.assertIs(getmetatable(root), Node)
  luaunit.assertNotNil(root)
  luaunit.assertNil(root.parent)
  luaunit.assertEquals(root.children, {})
end

function TestNode:test_add()
  luaunit.assertNil(self.root.parent)
  luaunit.assertIs(self.node1.parent, self.root)
  luaunit.assertIs(self.node2.parent, self.root)
  luaunit.assertIs(self.node3.parent, self.node2)

  luaunit.assertEquals(self.root.children, {self.node1, self.node2})
  luaunit.assertEquals(self.node1.children, {})
  luaunit.assertEquals(self.node2.children, { self.node3 })
  luaunit.assertEquals(self.node3.children, {})
end

function TestNode:test_last_child()
  luaunit.assertIs(self.root:last_child(), self.node2)
  luaunit.assertIs(self.node2:last_child(), self.node3)

  luaunit.assertNil(self.node1:last_child())
  luaunit.assertNil(self.node3:last_child())
end

function TestNode:test_level()
  luaunit.assertEquals(self.root:level(), 0)
  luaunit.assertEquals(self.node1:level(), 1)
  luaunit.assertEquals(self.node2:level(), 1)
  luaunit.assertEquals(self.node3:level(), 2)
end

function TestNode:test_find()
  luaunit.assertIs(self.root:find(function(node) return node == self.node3 end), self.node3)
  luaunit.assertIs(self.root:find(function(node) return node.parent ~= nil end), self.node1)

  luaunit.assertNotIs(self.root:find(function(node) return node:level() == 1 end), self.node2)

  luaunit.assertNil(self.root:find(function(node) return node:level() > 2 end))
  luaunit.assertNil(self.node2:find(function(node) return node == root end))

  luaunit.assertNotNil(self.root:find(function(node) return #node.children > 1 end))
end

function TestNode:test_find_parent()
  luaunit.assertIs(self.node3:find_parent(function(node) return node:level() == 0 end), self.root)
  luaunit.assertIs(self.node1:find_parent(function(node) return node == self.root end), self.root)
  luaunit.assertIs(self.node3:find_parent(function(node) return node:level() <= 1 end), self.node2)

  luaunit.assertNil(self.node3:find_parent(function(node) return node == self.node1 end))
  luaunit.assertNil(self.node3:find_parent(function(node) return node:level() < 0 end))
end

return TestNode
