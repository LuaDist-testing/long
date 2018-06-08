local Long = require 'long'

it('consts', function()
  assert.equal(false, Long.ZERO.unsigned)
  assert.equal(0, Long.ZERO.low)
  assert.equal(0, Long.ZERO.high)
  
  assert.equal(true, Long.UZERO.unsigned)
  assert.equal(0, Long.UZERO.low)
  assert.equal(0, Long.UZERO.high)
  
  assert.equal(false, Long.ONE.unsigned)
  assert.equal(1, Long.ONE.low)
  assert.equal(0, Long.ONE.high)
  
  assert.equal(true, Long.UONE.unsigned)
  assert.equal(1, Long.UONE.low)
  assert.equal(0, Long.UONE.high)
  
  assert.equal(false, Long.NEG_ONE.unsigned)
  assert.equal(-1, Long.NEG_ONE.low)
  assert.equal(-1, Long.NEG_ONE.high)
  
  assert.equal(false, Long.MAX_VALUE.unsigned)
  assert.equal(-1, Long.MAX_VALUE.low)
  assert.equal(2147483647, Long.MAX_VALUE.high)
  
  assert.equal(true, Long.MAX_UNSIGNED_VALUE.unsigned)
  assert.equal(-1, Long.MAX_UNSIGNED_VALUE.low)
  assert.equal(-1, Long.MAX_UNSIGNED_VALUE.high)
  
  assert.equal(false, Long.MIN_VALUE.unsigned)
  assert.equal(0, Long.MIN_VALUE.low)
  assert.equal(-2147483648, Long.MIN_VALUE.high)
end)

it('divide', function()
  assert.has_error(function() Long.ONE:divide(0) end)
  assert.has_error(function() Long.ONE:divide(Long.ZERO) end)
  
  assert.equal(0, Long.fromInt(0):divide(1):toInt())
  assert.equal(1, Long.fromInt(1):divide(1):toInt())
  
  assert.equal(0, Long.fromInt(1):divide(2):toInt())
  assert.equal(1, Long.fromInt(2):divide(2):toInt())
  assert.equal(2, Long.fromInt(4):divide(2):toInt())
  assert.equal(4, Long.fromInt(8):divide(2):toInt())
  
  local halfOfMax = Long.MAX_VALUE:divide(2)
  assert.equal(-1, halfOfMax.low)
  assert.equal(1073741823, halfOfMax.high)
end)

it('__div', function()
  assert.equal(Long.fromInt(7), Long.fromInt(21) / Long.fromInt(3))
end)

it('equal', function()
  assert.is_true(Long.ZERO:eq(Long.ZERO))
  assert.is_true(Long.NEG_ONE:eq(Long.NEG_ONE))
  assert.is_true(Long.ONE:eq(Long.ONE))
  assert.is_true(Long.MIN_VALUE:eq(Long.MIN_VALUE))
  
  assert.is_false(Long.ONE:eq(Long.ZERO))
  assert.is_false(Long.ONE:eq(Long.NEG_ONE))
end)

it('greaterThan', function()
  assert.is_true(Long.ONE:gt(Long.ZERO))
  assert.is_true(Long.MAX_VALUE:gt(Long.ZERO))
  assert.is_true(Long.MAX_VALUE:gt(Long.ONE))
  
  assert.is_false(Long.ZERO:gt(Long.ONE))
  assert.is_false(Long.ZERO:gt(Long.MAX_VALUE))
  assert.is_false(Long.NEG_ONE:gt(Long.ZERO))
  assert.is_false(Long.NEG_ONE:gt(Long.ONE))
  assert.is_false(Long.MIN_VALUE:gt(Long.ZERO))
  
  assert.is_false(Long.ZERO:gt(Long.ZERO))
  assert.is_false(Long.ONE:gt(Long.ONE))
  assert.is_false(Long.NEG_ONE:gt(Long.NEG_ONE))
end)

it('isEven', function()
  assert.is_false(Long.ONE:isEven())
  assert.is_false(Long.NEG_ONE:isEven())
  assert.is_false(Long.MAX_VALUE:isEven())
  assert.is_false(Long.MAX_UNSIGNED_VALUE:isEven())
  
  assert.is_true(Long.ZERO:isEven())
  assert.is_true(Long.UZERO:isEven())
  assert.is_true(Long.MIN_VALUE:isEven())
end)

it('isNegative', function()
  assert.is_true(Long.NEG_ONE:isNegative())
  assert.is_true(Long.MIN_VALUE:isNegative())

  assert.is_false(Long.ZERO:isNegative())
  assert.is_false(Long.UZERO:isNegative())
  assert.is_false(Long.ONE:isNegative())
  assert.is_false(Long.MAX_VALUE:isNegative())
  assert.is_false(Long.MAX_UNSIGNED_VALUE:isNegative())
end)

it('isOdd', function()
  assert.is_true(Long.ONE:isOdd())
  assert.is_true(Long.NEG_ONE:isOdd())
  assert.is_true(Long.MAX_VALUE:isOdd())
  assert.is_true(Long.MAX_UNSIGNED_VALUE:isOdd())
  
  assert.is_false(Long.ZERO:isOdd())
  assert.is_false(Long.UZERO:isOdd())
  assert.is_false(Long.MIN_VALUE:isOdd())
end)

it('isZero', function()
  assert.is_true(Long.ZERO:isZero())
  assert.is_true(Long.UZERO:isZero())
  
  assert.is_false(Long.ONE:isZero())
  assert.is_false(Long.NEG_ONE:isZero())
  assert.is_false(Long.MIN_VALUE:isZero())
  assert.is_false(Long.MAX_VALUE:isZero())
  assert.is_false(Long.MAX_UNSIGNED_VALUE:isZero())
end)

it('lessThan', function()
  assert.is_true(Long.ZERO:lt(Long.ONE))
  assert.is_true(Long.ZERO:lt(Long.MAX_VALUE))
  assert.is_true(Long.NEG_ONE:lt(Long.ZERO))
  assert.is_true(Long.NEG_ONE:lt(Long.ONE))
  assert.is_true(Long.MIN_VALUE:lt(Long.ZERO))
  
  assert.is_false(Long.ONE:lt(Long.ZERO))
  
  assert.is_false(Long.ZERO:lt(Long.ZERO))
  assert.is_false(Long.ONE:lt(Long.ONE))
  assert.is_false(Long.NEG_ONE:lt(Long.NEG_ONE))
end)

it('__lt', function()
  assert.is_true(Long.ZERO < Long.ONE)
  assert.is_false(Long.ONE < Long.ZERO)
end)

it('__le', function()
  assert.is_true(Long.ZERO <= Long.ONE)
  assert.is_true(Long.ONE <= Long.ONE)
  assert.is_false(Long.ONE <= Long.ZERO)
end)

it('__mod', function()
  assert.equal(Long.fromInt(2), Long.fromInt(17) % Long.fromInt(3))
end)

it('multiply', function()
  assert.equal(0, Long.fromInt(0):multiply(0):toInt())
  assert.equal(0, Long.fromInt(0):multiply(1):toInt())
  assert.equal(0, Long.fromInt(1):multiply(0):toInt())
  assert.equal(1, Long.fromInt(1):multiply(1):toInt())
  assert.equal(2, Long.fromInt(1):multiply(2):toInt())
  assert.equal(4, Long.fromInt(2):multiply(2):toInt())
  
  assert.equal(-4, Long.fromInt(2):multiply(-2):toInt())
  assert.equal(-4, Long.fromInt(-2):multiply(2):toInt())
  assert.equal(4, Long.fromInt(-2):multiply(-2):toInt())
  
  assert.equal(-2, Long.fromInt(0x7fffffff):multiply(2).low)
  assert.equal(0, Long.fromInt(0x7fffffff):multiply(2).high)
  
  assert.equal(-4, Long.fromBits(-2, 10):multiply(2).low)
  assert.equal(21, Long.fromBits(-2, 10):multiply(2).high)
  
  assert.equal(Long.MAX_VALUE, Long.MAX_VALUE:multiply(1))
  
  assert.equal(-4, Long.fromInt(2):multiply(Long.fromBits(-2, 10)).low)
  assert.equal(21, Long.fromInt(2):multiply(Long.fromBits(-2, 10)).high)
end)

it('__mul', function()
  assert.equal(Long.fromInt(21), Long.fromInt(7) * Long.fromInt(3))
end)

it('negate', function()
  assert.equal(Long.fromInt(-7), Long.fromInt(7):negate())
  assert.equal(Long.fromInt(7), Long.fromInt(-7):negate())
end)

it('__unm', function()
  assert.equal(Long.fromInt(-7), -Long.fromInt(7))
  assert.equal(Long.fromInt(7), -Long.fromInt(-7))
end)

it('shiftLeft', function()
  assert.equal(0, Long.fromInt(0):shiftLeft(1):toInt())
  
  assert.equal(2, Long.fromInt(1):shiftLeft(1):toInt())
  assert.equal(4, Long.fromInt(1):shiftLeft(2):toInt())
  assert.equal(8, Long.fromInt(1):shiftLeft(3):toInt())
  assert.equal(16, Long.fromInt(1):shiftLeft(4):toInt())
  
  assert.equal(-2, Long.fromInt(-1):shiftLeft(1):toInt())
  assert.equal(-4, Long.fromInt(-1):shiftLeft(2):toInt())
  assert.equal(-8, Long.fromInt(-1):shiftLeft(3):toInt())
  assert.equal(-16, Long.fromInt(-1):shiftLeft(4):toInt())
  
  assert.equal(6, Long.fromInt(3):shiftLeft(1):toInt())
  assert.equal(12, Long.fromInt(3):shiftLeft(2):toInt())
  assert.equal(24, Long.fromInt(3):shiftLeft(3):toInt())
  assert.equal(48, Long.fromInt(3):shiftLeft(4):toInt())
  
  assert.equal(-2, Long.fromInt(0xffffffff):shiftLeft(1).low)
  assert.equal(-1, Long.fromInt(0xffffffff):shiftLeft(1).high)
  
end)

it('shiftRight', function()
  assert.equal(0, Long.fromInt(0):shiftRight(1):toInt())
  assert.equal(0, Long.fromInt(1):shiftRight(1):toInt())
  assert.equal(1, Long.fromInt(2):shiftRight(1):toInt())
  assert.equal(1, Long.fromInt(3):shiftRight(1):toInt())
  assert.equal(2, Long.fromInt(4):shiftRight(1):toInt())
  assert.equal(2, Long.fromInt(5):shiftRight(1):toInt())
  assert.equal(3, Long.fromInt(6):shiftRight(1):toInt())
  assert.equal(3, Long.fromInt(7):shiftRight(1):toInt())
  
  assert.equal(-1, Long.fromInt(-1):shiftRight(1):toInt())
  assert.equal(-1, Long.fromInt(-2):shiftRight(1):toInt())
  assert.equal(-2, Long.fromInt(-3):shiftRight(1):toInt())
  assert.equal(-2, Long.fromInt(-4):shiftRight(1):toInt())
end)

it('__sub', function()
  assert.equal(3, Long.fromInt(5):sub(2):toInt())
  assert.equal(Long.fromInt(3), Long.fromInt(5) - Long.fromInt(2))
end)

it('toInt', function()
  assert.equal(0, Long.ZERO:toInt())
  assert.equal(1, Long.ONE:toInt())
  assert.equal(-1, Long.MAX_VALUE:toInt())
  assert.equal(4294967295, Long.MAX_UNSIGNED_VALUE:toInt())
  assert.equal(-1, Long.NEG_ONE:toInt())
end)
