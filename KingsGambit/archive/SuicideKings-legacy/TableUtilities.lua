function PrintTableValues(table)
  for i, v in pairs(table) do
      local name = unpack(v)
      print("i = " .. i .. " v = " .. name)
  end
end

function GetTableLength(table)
  local count = 0
  if table ~= nil then for _, _ in pairs(table) do count = count + 1 end end
  return count
end