local utils = {}

function utils.starts(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

return utils
