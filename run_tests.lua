local dir = require("pl.dir")
local path = require("pl.path")
local stringx = require("pl.stringx")
local luaunit = require("luaunit")

-- Add `src` directory to lua path.
package.path = package.path .. ';src/?.lua'

-- Add all .*test.lua files to the test suite.
for test_file, mode in dir.dirtree(".") do
  if not mode and test_file:match(".*test%.lua$") then
    local test_module = string.gsub(test_file, "%.lua$", "")
    local test_name = "Test_" .. string.gsub(path.basename(test_file),
                                             "_?test%.lua", "")

    _G[test_name] = require(test_module)
  end
end

os.exit( luaunit.LuaUnit.run() )
