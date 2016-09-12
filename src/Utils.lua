local utils = {}

function utils.starts(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

function utils.ends(str,ending)
  return ending == '' or string.sub(str,-string.len(ending)) == ending
end

return utils
