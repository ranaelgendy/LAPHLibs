package.path = package.path..";../?.lua"

local bit = require("bit")
local lshift = bit.lshift;
local pow = math.pow;

local maths = require("maths")
local isPowerOfTwo = maths.is_power_of_two;
local round = maths.round;


local function test_poweroftwo()
	for i=0,31 do
		value = lshift(1, i);

		print(i, value, pow(2, i), isPowerOfTwo(value))
	end

	for i=0,32 do
		print(i, isPowerOfTwo(i))
	end

end

test_poweroftwo();
