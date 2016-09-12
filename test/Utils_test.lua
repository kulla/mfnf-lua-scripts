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

function TestUtils:test_ends()
  luaunit.assertTrue(utils.ends("aab", "b"))
  luaunit.assertTrue(utils.ends("aab", "ab"))
  luaunit.assertTrue(utils.ends("aaa", ""))
  luaunit.assertTrue(utils.ends("", ""))

  luaunit.assertFalse(utils.ends("aab", "a"))
  luaunit.assertFalse(utils.ends("aaa", "ab"))
  luaunit.assertFalse(utils.ends("", "a"))
  luaunit.assertFalse(utils.ends("aa", "aaa"))
end

return TestUtils
