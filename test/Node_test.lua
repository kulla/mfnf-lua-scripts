luaunit = require("luaunit")
node = require("Node")

local TestNode = {}

local root, node_1, node_2, node_3 = node:new(), node:new(), node:new(), node:new()
root:add_child(node_1)
root:add_child(node_2)
node_2:add_child(node_3)

function TestNode:test_new()
  luaunit.assertTrue(root)
  luaunit.assertFalse(root.parent)
end

function TestNode:test_add()
  luaunit.assertTrue(node_1.parent == root)
  luaunit.assertTrue(node_2.parent == root)
  luaunit.assertTrue(node_3.parent == node_2)
  luaunit.assertTrue(#root.children == 2 and #node_2.children == 1)
end

function TestNode:test_last_child()
  luaunit.assertTrue(root:last_child() == node_2)
  luaunit.assertTrue(node_2:last_child() == node_3)

  luaunit.assertFalse(node_1:last_child())
  luaunit.assertFalse(node_3:last_child())
end

return TestNode