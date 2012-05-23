package.path = package.path .. ';?/init.lua;test/?.lua'

local lunit   = require 'lunit'
local helpers = require 'iterators.test.helpers'

local it = require 'iterators'

module('iterators.tests.ipairs', package.seeall, lunit.testcase)

function test_ipairs()
  local t = {
    17,
    18,
    19,
  }

  local indices = setmetatable({}, { __index = table })
  local values  = setmetatable({}, { __index = table })

  for i, v in it.ipairs(t) do
    indices:insert(i)
    values:insert(v)
  end

  helpers.assert_list_equal({ 1, 2, 3 }, indices)
  helpers.assert_list_equal({ 17, 18, 19 }, values)
end
