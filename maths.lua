local bit = require("bit")
local band, bor = bit.band, bit.bor 
local rshift, lshift = bit.rshift, bit.lshift

local limits = require("limits")

local floor = math.floor;
local ceil = math.ceil;

-- because it's not in the standard math library
local function round(n)
	if n >= 0 then
		return floor(n+0.5)
	end

	return ceil(n-0.5)
end

local function is_power_of_two(value)
	if value == 0 then
		return false;
	end

	return band(value, (value-1)) == 0;
end

-- round up to the nearest
-- power of 2
local function roundup32(x) 
	x = x - 1; 
	x = bor(x,rshift(x,1)); 
	x = bor(x,rshift(x,2)); 
	x = bor(x,rshift(x,4)); 
	x = bor(x,rshift(x,8)); 
	x = bor(x,rshift(x,16)); 
	x = x + 1;
	
	return x
end

local function min_bytes_needed(value)
    local bytes;
    
    if (value <= limits.UINT32_MAX) then
        if (value < 16777216) then
            if (value <= limits.UINT16_MAX) then
                if (value <= limits.UINT8_MAX) then 
                    bytes = 1;
                else 
                    bytes = 2;
                end
            else 
                bytes = 3;
            end
        else 
            bytes = 4;
        end
    
    elseif (value <= limits.UINT64_MAX) then 
        if (value < 72057594000000000ULL) then 
            if (value < 281474976710656ULL) then
                if (value < 1099511627776ULL) then
                    bytes = 5;
                else 
                    bytes = 6;
                end
            else 
                bytes = 7;
            end
        else 
            bytes = 8;
        end
    end

    return bytes;
end

local exports = {
	is_power_of_two = is_power_of_two;
	min_bytes_needed = min_bytes_needed;
	round = round;
	roundup = roundup32;
}

return exports;
