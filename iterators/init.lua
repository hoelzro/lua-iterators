local _M = {
  name = 'iterators',
}
_M._M = _M

function _M:pairs()
  local mt = {}

  -- XXX refactor
  function mt:__call(s, v)
    return next(s, v)
  end

  mt.__index = _M

  return setmetatable({ __state = self }, mt), self, nil
end

return _M
