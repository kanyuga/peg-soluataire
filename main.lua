---
-- The entry point.
-- The game states are as follows:
--    Start game - Select rows & columns for the size of the board
--    Play - Enter rows and columns to select cells until the game is won or lost
--    End game - Display the outcome of the game

Class = require "Class"

require 'StateMachine'

require 'states/BaseState'
require 'states/StartState'
require 'states/PlayState'
require 'states/EndState'

require "Cell"
require "GameBoard"
require "utils"

math.randomseed(os.time())

gStateMachine = StateMachine {
    ['start'] = function() return StartState() end,
    ['play'] = function() return PlayState() end,
    ['end'] = function() return EndState() end
}
gStateMachine:change('start')

-- game loop
while true do
    gStateMachine:render()
    local input = io.read()
    if (input == 'x') then
        os.exit()
    end
    gStateMachine:update(input)
end


