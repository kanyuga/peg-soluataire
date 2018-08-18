---
--  @class GameBoard
--  @property number row_count -  the number of rows on the board
--  @property number column_count - the number of columns per row
--  @property number filled_cell_count - the total number of filled cells on the board
--  @property [Cell] cells - a table of the rows of cells on the board
--  @property Cell selected_cell - the currently selected cell. Is nil if none is selected


GameBoard = Class{}
function GameBoard:init(row_count, column_count)
    self.row_count = row_count
    self.column_count = column_count

    self.filled_cell_count = row_count * column_count
    self.cells = {}
    self:initCells()
    self.selected_cell = nil
end

---
-- Populate the board with filled cells. For each cell, also set the adjacent cells if available
--

function GameBoard:initCells()
    for row_index=1, self.row_count do
        self.cells[row_index] = {}
        for column_index=1, self.column_count do
            self.cells[row_index][column_index] = Cell(row_index, column_index)

            if row_index > 1 then
                self.cells[row_index][column_index].top = self.cells[row_index - 1][column_index]
                self.cells[row_index - 1][column_index].bottom = self.cells[row_index][column_index]
            end

            if column_index > 1 then
                self.cells[row_index][column_index].left = self.cells[row_index][column_index - 1]
                self.cells[row_index][column_index - 1].right = self.cells[row_index][column_index]
            end

        end
    end
end

function GameBoard:selectCell(cell)
    self.selected_cell = cell
end

function GameBoard:deselectCell()
    self.selected_cell = nil
end

---
-- Whether or not the game is won. The game is won if there is only one filled cell left on
-- the board
-- @return boolean
function GameBoard:isGameWon()
    return self.filled_cell_count == 1
end

---
-- Whether or not the game is lost. If none of the cells can be emptied, there are no more
-- playable moves, ergo the game is lost
-- @return boolean - whether or not the game is lost
function GameBoard:isGameLost()
    for row_index=1, self.row_count do
        for column_index=1, self.column_count do
            if (self.cells[row_index][column_index]:canBeEmptied()) then
                return false
            end
        end
    end
    return true
end

---
-- Play by selecting a cell.
-- If the cell is filled and no previous cell has been selected, make this cell the
-- selected cell.
-- If a previous cell has been selected and the current cell is not filled, and there is a
-- skipped cell - a single filled cell between the current and previously selected cell -, then
--   1. mark the previously selected cell and the skipped cell as empty
--   2. mark the current cell as filled
--
-- If a previous cell has been selected always deselect it after checking the above conditions.
-- @param number row_index
-- @param number column_index

function GameBoard:play(row_index, column_index)
    if (row_index >= 1 and row_index <= #self.cells) and (column_index >= 1 and column_index <= #self.cells[1]) then
        local cell = self.cells[row_index][column_index]
        if cell.filled then
            if not self.selected_cell then
                self:selectCell(cell)
            else
                self:deselectCell()
            end
        elseif self.selected_cell then
            -- Diagonal plays are disallowed by ensuring only the column or row changes and not both
            local skipped_cell_row, skipped_cell_column = row_index, column_index
            if (math.abs(row_index - self.selected_cell.row_index) == 2
                and column_index == self.selected_cell.column_index) then
                skipped_cell_row = math.avg(row_index, self.selected_cell.row_index)
            elseif (math.abs(column_index - self.selected_cell.column_index) == 2 and row_index == self.selected_cell.row_index) then
                skipped_cell_column = math.avg(column_index, self.selected_cell.column_index)
            end
            if skipped_cell_column ~= column_index or skipped_cell_row ~= row_index then
                local skipped_cell = self.cells[skipped_cell_row][skipped_cell_column]
                if skipped_cell.filled then
                    skipped_cell:empty()
                    cell:fill()
                    self.selected_cell:empty()
                    self.filled_cell_count = self.filled_cell_count - 1
                end
            end
            self:deselectCell()
        end
    end
end

function GameBoard:print()
    if self.selected_cell then
        print("Selected Cell", self.selected_cell.row_index, self.selected_cell.column_index)
    end
    for i, row in pairs(self.cells) do
        local str = ""
        for j, cell in pairs(row) do
            if self.selected_cell == cell then
                str = str .. "X"
            elseif cell.filled then
                str = str .. "O"
            else
                str = str .. "-"
            end
            str = str .. " "
        end
        print(str)
    end
end

---
-- Start the game by randomly emptying one of the cells
--

function GameBoard:startGame()
    local row_index, column_index = math.random(#self.cells), math.random(#self.cells[1])
    self.cells[row_index][column_index]:empty()
    self.filled_cell_count = self.filled_cell_count - 1
end