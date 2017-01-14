luaunit = require("luaunit")
Node = require("Node")

local TestNode = {}

--- Sets up the following tree:
--
-- root
--  |- node1
--      |- node2
--      |- node3
--          |- node4
--  |- node5
function TestNode:setUp()
  self.root = Node:new()
  self.node1 = Node:new()
  self.node2 = Node:new()
  self.node3 = Node:new()
  self.node4 = Node:new()
  self.node5 = Node:new()

  self.root:add_child(self.node1)
  self.node1:add_child(self.node2)
  self.node1:add_child(self.node3)
  self.node3:add_child(self.node4)
  self.root:add_child(self.node5)
end

function TestNode:test_new()
  local root = Node:new()

  luaunit.assertIs(getmetatable(root), Node)
  luaunit.assertNotNil(root)
  luaunit.assertNil(root.parent)
  luaunit.assertEquals(root.children, {})
end

function TestNode:test_add_child()
  luaunit.assertNil(self.root.parent)
  luaunit.assertIs(self.node1.parent, self.root)
  luaunit.assertIs(self.node2.parent, self.node1)
  luaunit.assertIs(self.node3.parent, self.node1)
  luaunit.assertIs(self.node4.parent, self.node3)
  luaunit.assertIs(self.node5.parent, self.root)

  luaunit.assertEquals(self.root.children, {self.node1, self.node5})
  luaunit.assertEquals(self.node1.children, {self.node2, self.node3})
  luaunit.assertEquals(self.node2.children, {})
  luaunit.assertEquals(self.node3.children, { self.node4 })
  luaunit.assertEquals(self.node4.children, {})
  luaunit.assertEquals(self.node5.children, {})
end

function TestNode:test_last_child()
  luaunit.assertIs(self.root:last_child(), self.node5)
  luaunit.assertIs(self.node1:last_child(), self.node3)

  luaunit.assertNil(self.node2:last_child())
  luaunit.assertNil(self.node4:last_child())
end

function TestNode:test_level()
  luaunit.assertEquals(self.root:level(), 0)
  luaunit.assertEquals(self.node1:level(), 1)
  luaunit.assertEquals(self.node2:level(), 2)
  luaunit.assertEquals(self.node3:level(), 2)
  luaunit.assertEquals(self.node4:level(), 3)
  luaunit.assertEquals(self.node5:level(), 1)
end

function TestNode:test_find()
  luaunit.assertIs(self.root:find(function(node) return node == self.node3 end), self.node3)
  luaunit.assertIs(self.root:find(function(node) return node.parent ~= nil end), self.node1)
  luaunit.assertIs(self.root:find(function(node) return node:level() == 1 end), self.node1)

  luaunit.assertNil(self.root:find(function(node) return node:level() > 3 end))
  luaunit.assertNil(self.node1:find(function(node) return node == root end))

  luaunit.assertNotNil(self.root:find(function(node) return #node.children > 1 end))
end

function TestNode:test_find_parent()
  luaunit.assertIs(self.node3:find_parent(function(node) return node:level() == 0 end), self.root)
  luaunit.assertIs(self.node1:find_parent(function(node) return node == self.root end), self.root)
  luaunit.assertIs(self.node3:find_parent(function(node) return node:level() <= 1 end), self.node1)

  luaunit.assertNil(self.node4:find_parent(function(node) return node == self.node5 end))
  luaunit.assertNil(self.node4:find_parent(function(node) return node:level() < 0 end))
end

return TestNode
