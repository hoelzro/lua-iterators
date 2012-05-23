package.path = package.path .. ';?/init.lua;test/?.lua'

local lunit   = require 'lunit'
local helpers = require 'iterators.test.helpers'

local it = require 'iterators'

module('iterators.tests.chain', package.seeall, lunit.testcase)

function test_keys()
  local t = {
    foo = 17,
    bar = 18,
    baz = 19,
  }

  local keys = setmetatable({}, { __index = table })

  for k, v in it.pairs(t):keys() do
    keys:insert(k)
    assert_nil(v)
  end
  helpers.assert_set_equal({ 'foo', 'bar', 'baz' }, keys)
end

function test_keys_each()
  local t = {
    foo = 17,
    bar = 18,
    baz = 19,
  }

  local results = setmetatable({}, { __index = table })

  it.pairs(t):keys():each(function(key)
    results:insert(key)
  end)

  helpers.assert_set_equal({ 'foo', 'bar', 'baz' }, results)
end
