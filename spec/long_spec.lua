--[[
 Copyright 2013 Daniel Wirtz <dcode@dcode.io>

 Licensed under the Apache License, Version 2.0 (the "License")
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS-IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--]]

local Long = require 'long'

it('basic', function()
  local longVal = Long:new(0xFFFFFFFF, 0x7FFFFFFF)
  assert.equal(9223372036854775807, longVal:toNumber())
  assert.equal("9223372036854775807", longVal:toString())
  local longVal2 = Long.fromValue(longVal)
  assert.equal(9223372036854775807, longVal2:toNumber())
  assert.equal("9223372036854775807", longVal2:toString())
  assert.equal(longVal.unsigned, longVal2.unsigned)
end)

it('isLong', function()
  local longVal = Long:new(0xFFFFFFFF, 0x7FFFFFFF)
  assert.equal(Long.isLong(longVal), true)
end)

it('toBytes', function()
  local longVal = Long.fromBits(0x01234567, 0x12345678)
  assert.same(longVal:toBytesBE(), {
      0x12, 0x34, 0x56, 0x78,
      0x01, 0x23, 0x45, 0x67
  })
  assert.same(longVal:toBytesLE(), {
      0x67, 0x45, 0x23, 0x01,
      0x78, 0x56, 0x34, 0x12
  })
end)

describe('unsigned', function()

--  it('min/max', function()
--    assert.equal("-9223372036854775808", Long.MIN_VALUE.toString())
--    assert.equal("9223372036854775807", Long.MAX_VALUE.toString())
--    assert.equal("18446744073709551615", Long.MAX_UNSIGNED_VALUE.toString())
--  end)

  it('construct_negint', function()
    local longVal = Long.fromInt(-1, true)
    assert.equal(-1, longVal.low)
    assert.equal(-1, longVal.high)
    assert.equal(true, longVal.unsigned)
    assert.equal(18446744073709551615, longVal:toNumber())
    --assert.equal("18446744073709551615", longVal:toString())
  end)

  it('construct_highlow', function()
    local longVal = Long:new(0xFFFFFFFF, 0xFFFFFFFF, true)
    assert.equal(-1, longVal.low)
    assert.equal(-1, longVal.high)
    assert.equal(true, longVal.unsigned)
    assert.equal(18446744073709551615, longVal:toNumber())
    --assert.equal("18446744073709551615", longVal.toString())
  end)

  it('construct_number', function()
      local longVal = Long.fromNumber(0xFFFFFFFFFFFFFFFF, true)
      assert.equal(-1, longVal.low)
      assert.equal(-1, longVal.high)
      assert.equal(true, longVal.unsigned)
      assert.equal(18446744073709551615, longVal:toNumber())
      --assert.equal(18446744073709551615, longVal:toString())
  end)
  
  it('toSigned/Unsigned', function()
    local longVal = Long.fromNumber(-1, false)
    assert.equal(-1, longVal:toNumber())
    longVal = longVal:toUnsigned()
    assert.equal(0xFFFFFFFFFFFFFFFF, longVal:toNumber())
    --assert.equal('ffffffffffffffff', longVal:toString(16))
    longVal = longVal:toSigned()
    assert.equal(-1, longVal:toNumber())
  end)

  it('max_unsigned_sub_max_signed', function()
    local longVal = Long.MAX_UNSIGNED_VALUE:subtract(Long.MAX_VALUE):subtract(Long.ONE)
    assert.equal(Long.MAX_VALUE:toNumber(), longVal:toNumber())
    assert.equal(Long.MAX_VALUE:toString(), longVal:toString())
  end)

  it('max_sub_max', function()
    local longVal = Long.MAX_UNSIGNED_VALUE:subtract(Long.MAX_UNSIGNED_VALUE)
    assert.equal(Long.ZERO, longVal)
    assert.equal(0, longVal.low)
    assert.equal(0, longVal.high)
    assert.equal(true, longVal.unsigned)
    assert.equal(0, longVal:toNumber())
    assert.equal("0", longVal:toString())
  end)

  it('zero_sub_signed', function()
    local longVal = Long.fromInt(0, true):add(Long.fromInt(-1, false))
    assert.equal(-1, longVal.low)
    assert.equal(-1, longVal.high)
    assert.equal(true, longVal.unsigned)
    assert.equal(18446744073709551615, longVal:toNumber())
    --assert.equal("18446744073709551615", longVal:toString())
  end)

  it('max_unsigned_div_max_signed', function()
    local longVal = Long.MAX_UNSIGNED_VALUE:div(Long.MAX_VALUE)
    assert.equal(2, longVal:toNumber())
    assert.equal("2", longVal:toString())
  end)
  
end)
