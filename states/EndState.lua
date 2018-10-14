---
-- @class EndState
-- @extends BaseState
-- @property boolean isWin

EndState = Class{ __includes = BaseState }

function EndState:enter(params)
    self.isWin = params.isWin
end

function EndState:render()
    print(self.isWin and "You Won" or "You Lost")
end

function EndState:update()
    gStateMachine:change('start')
end