---
-- Lua doesn't have a average function by default, so here's a mean one.
-- @param [number] ... - The numbers to average passed in as individual function parameters
-- @example math.avg(1, 3) -> 2

function math.avg(...)
    local values = {...}
    local sum = 0
    for i=1, #values do
        sum = sum + values[i]
    end
    return sum/#values
end