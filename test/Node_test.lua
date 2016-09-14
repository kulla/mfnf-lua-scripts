luaunit = require("luaunit")
node = require("Node")

local TestNode = {}

local root, node_1, node_2, node_3 = node:new(), node:new(), node:new(), node:new()

function TestNode:test_new()
  luaunit.assertTrue(root)
  luaunit.assertFalse(root.parent)
end

return TestNode