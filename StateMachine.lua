---
-- @class StateMachine
-- @property {} empty - the default empty state
-- @property {} states - the available states
-- @property {} current - the current state


StateMachine = Class{}

function StateMachine:init(states)
    self.emptyState = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }
    self.states = states or {}
    self.current = self.emptyState
end

---
-- Exit from the current state and switch to a new state
-- @param stateName
-- @param [] enterParams - a table of params to be passed to the new state's enter method

function StateMachine:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName] ()
    self.current:enter(enterParams)
end

---
-- Update the current state. We are using key inputs as triggers
-- @param string input

function StateMachine:update(input)
    self.current:update(input)
end


---
-- Render the current state

function StateMachine:render()
    self.current:render()
end

