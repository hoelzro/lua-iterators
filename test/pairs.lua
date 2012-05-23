package.path = package.path .. ';?/init.lua;test/?.lua'

local lunit   = require 'lunit'
local helpers = require 'iterators.test.helpers'

local it = require 'iterators'

module('iterators.tests.pairs', package.seeall, lunit.testcase)

function test_pairs()
  local t = {
    foo = 17,
    bar = 18,
    baz = 19,
  }

  local keys   = setmetatable({}, { __index = table })
  local values = setmetatable({}, { __index = table })

  for k, v in it.pairs(t) do
    keys:insert(k)
    values:insert(v)
  end

  local reconstructed = {}

  for i, key in ipairs(keys) do
    local value = values[i]

    reconstructed[key] = value
  end

  helpers.assert_set_equal({ 'foo', 'bar', 'baz' }, keys)
  helpers.assert_set_equal({ 17, 18, 19 }, values)
  helpers.assert_hash_equal(t, reconstructed)
end
