luaunit = require("luaunit")
utils = require("Utils")

local TestUtils = {}

function TestUtils:test_starts()
  luaunit.assertTrue(utils.starts("aaa", "a"))
  luaunit.assertTrue(utils.starts("aaa", "aa"))
  luaunit.assertTrue(utils.starts("aaa", ""))
  luaunit.assertTrue(utils.starts("", ""))

  luaunit.assertFalse(utils.starts("aaa", "b"))
  luaunit.assertFalse(utils.starts("aaa", "ab"))
  luaunit.assertFalse(utils.starts("", "ab"))
  luaunit.assertFalse(utils.starts("aa", "aaa"))
end

return TestUtils
