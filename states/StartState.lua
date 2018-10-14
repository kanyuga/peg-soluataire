---
-- @class StartState
-- @extends BaseState
-- @property number rows - the number of rows to be on the board

StartState = Class{ __includes = BaseState }

function StartState:enter()
    self.rows = 0
end

function StartState:render()
    print("Enter number of " .. ( self.rows > 0 and "columns" or "rows") .. " (>= 4)")
end

function StartState:update(input)
    local inputNumber = tonumber(input)
    if (self.rows < 4) then
        self.rows = inputNumber
    elseif (inputNumber >= 4) then
        gStateMachine:change('play', { rows = self.rows, columns = inputNumber })
    end
end