local _M = {}

local lunit = require 'lunit'

function _M.assert_set_equal(lhs, rhs)
  local element_counts = {}

  for _, element in ipairs(lhs) do
    element_counts[element] = (element_counts[element] or 0) + 1
  end

  for _, element in ipairs(rhs) do
    element_counts[element] = (element_counts[element] or 0) + 1
  end

  for _, count in pairs(element_counts) do
    if count ~= 2 then
      lunit.fail()
      return
    end
  end
  lunit.assert_true(true)
end

function _M.assert_hash_equal(lhs, rhs)
  for k, v in pairs(lhs) do
    local v2 = rhs[k]

    if v ~= v2 then
      lunit.fail()
      return
    end
  end

  for k, v in pairs(rhs) do
    local v2 = lhs[k]

    if v ~= v2 then
      lunit.fail()
      return
    end
  end
  lunit.assert_true(true)
end

return _M
