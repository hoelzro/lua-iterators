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

function _M:clone()
  return setmetatable({}, { __index = self })
end

function _M.create(f, s, v)
  local mt = {}

  function mt:__call(s, v)
    return f(self.__state, v)
  end

  mt.__index = _M

  return setmetatable({ __state = s }, mt)
end

function _M.wrap(f)
  return function(...)
    return _M.create(f(...))
  end
end

_M.pairs  = _M.wrap(pairs)
_M.ipairs = _M.wrap(ipairs)

function _M:select(index)
  local outerself = self

  return _M.create(function(s, v)
    local vars = capture_all(outerself(s, v))
    return vars[index]
  end, self.__state, nil)
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

_M.__index = _M

-- XXX modify select to accept multiple indices
-- XXX add function to swap k, v -> v, k

return _M
