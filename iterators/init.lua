local _M = {
  name = 'iterators',
}
_M._M = _M

local function capture_all(...)
  local n = select('#', ...)

  return {
    n = n,
    ...
  }
end

function _M:pairs()
  local mt = {}

  -- XXX refactor
  function mt:__call(s, v)
    return next(s, v)
  end

  mt.__index = _M

  return setmetatable({ __state = self }, mt), self, nil
end

function _M:select(index)
  local mt = {}

  local outerself = self

  -- XXX refactor
  function mt:__call(s, v)
    local vars = capture_all(outerself(s, v))
    return vars[index]
  end

  mt.__index = _M

  return setmetatable({ __state = self.__state }, mt), self.__state, nil
end


function _M:each(fn)
  local f, s, v = self, self.__state, nil

  repeat
    local vars = capture_all(f(s, v))
    v          = vars[1]

    if v ~= nil then
      fn(unpack(vars, 1, vars.n))
    end
  until v == nil
end

function _M:first()
  return self:select(1)
end

function _M:second()
  return self:select(2)
end

_M.keys   = _M.first
_M.values = _M.second

return _M
