luaunit = require("luaunit")
Node = require("Node")

local TestNode = {}

local root, node_1, node_2, node_3 = Node:new(), Node:new(), Node:new(), Node:new()
root:add_child(node_1)
root:add_child(node_2)
node_2:add_child(node_3)

function TestNode:test_new()
  luaunit.assertIs(getmetatable(root), Node)

  luaunit.assertNotNil(root)

  luaunit.assertNil(root.parent)

  luaunit.assertItemsEquals(root.children, {})
end

function TestNode:test_add()
  luaunit.assertIs(node_1.parent, root)
  luaunit.assertIs(node_2.parent, root)
  luaunit.assertIs(node_3.parent, node_2)

  luaunit.assertEquals(#root.children, 2)
  luaunit.assertEquals(#node_2.children, 1)
end

function TestNode:test_last_child()
  luaunit.assertIs(root:last_child(), node_2)
  luaunit.assertIs(node_2:last_child(), node_3)

  luaunit.assertFalse(node_1:last_child())
  luaunit.assertFalse(node_3:last_child())
end

function TestNode:test_level()
  luaunit.assertEquals(root:level(), 0)
  luaunit.assertEquals(node_1:level(), 1)
  luaunit.assertEquals(node_2:level(), 1)
  luaunit.assertEquals(node_3:level(), 2)
end

function TestNode:test_find()
  luaunit.assertIs(root:find(function(node) return node == node_3 end), node_3)
  luaunit.assertIs(root:find(function(node) return node.parent ~= nil end), node_1)

  luaunit.assertNotIs(root:find(function(node) return node:level() == 1 end), node_2)

  luaunit.assertNil(root:find(function(node) return node:level() > 2 end))
  luaunit.assertNil(node_2:find(function(node) return node == root end))

  luaunit.assertNotNil(root:find(function(node) return #node.children > 1 end))
end

return TestNode