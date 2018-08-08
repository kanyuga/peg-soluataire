---
-- The entry point
--

Class = require "Class"
require "Cell"
require "GameBoard"

ROWS = 4
COLUMNS = 4

math.randomseed(os.time())

function math.avg(...)
    local values = {...}
    local sum = 0
    for i=1, #values do
        sum = sum + values[i]
    end
    return sum/#values
end


board = GameBoard(ROWS, COLUMNS)

board:print()

board:startGame()

board:print()

while true do
    print ("Enter a column")
    local column = io.read("*n", "*l")

    print ("Enter a row")
    local row = io.read("*n", "*l")

    board:play(row, column)
    board:print()
    if board:isGameWon() or board:isGameLost() then
        break
    end
end

if board:isGameWon() then
    print ("You Won!")
else
    print ("You Lost!")
end

