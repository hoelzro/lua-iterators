package.path = package.path .. ';?/init.lua;test/?.lua'

local lunit   = require 'lunit'
local helpers = require 'iterators.test.helpers'

local it = require 'iterators'

module('iterators.tests.clone', package.seeall, lunit.testcase)

function test_clone()
  local it_copy = it:clone()

  it_copy.foo = function()
  end

  assert_nil(it.foo)
  assert_not_nil(it_copy.foo)
end
