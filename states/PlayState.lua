---
-- @class PlayState
-- @extends BaseState
-- @property number rows - the number of rows on the board
-- @property number columns - the number of columns on the board
-- @property number selectedColumn - the column index of the cell to be selected
-- @property number selectedRow - the row index of the cell to be selected
-- @property GameBoard board

PlayState = Class{ __includes = BaseState }

function PlayState:enter(params)
    self.rows = params.rows
    self.columns = params.columns

    self.selectedColumn = 0
    self.selectedRow = 0

    self.board = GameBoard(self.rows, self.columns)
    self.board:startGame()
end


function PlayState:render()
    -- Don't print the board between the row and column inputs
    if (self.selectedRow == 0) then
        self.board:print()
    end
    print("Enter a " .. (self.selectedRow > 0 and "column" or "row") .. " number")
end

function PlayState:update(input)
    local inputNumber = tonumber(input)
    if (self.selectedRow == 0) then
        if (inputNumber > 0 and inputNumber <= self.rows) then
            self.selectedRow = inputNumber
        end
    elseif (inputNumber > 0 and inputNumber <= self.columns) then
        self.selectedColumn = inputNumber
        self.board:play(self.selectedRow, self.selectedColumn)
        self.selectedRow = 0
        self.selectedColumn = 0
    end

    if self.board:isGameWon() then
        gStateMachine:change('end', { isWin = true })
    elseif self.board:isGameLost() then
        gStateMachine:change('end', { isWin = false })
    end
end