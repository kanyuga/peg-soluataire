---
-- This class represents a cell on the board
-- @property number row_index
-- @property number column_index
-- @property boolean filled - whether or not the cell is currently filled
-- @property Cell top - the cell to the top of this cell
-- @property Cell bottom - the cell to the bottom of this cell
-- @property Cell left - the cell to the left of this cell
-- @property Cell right - the cell to the right of this cell

Cell = Class{ }

function Cell:init(row_index, column_index)
    self.row_index = row_index
    self.column_index = column_index
    self.filled = true
end

function Cell:empty()
    self.filled = false
end

function Cell:fill()
    self.filled = true
end

---
-- Whether a cell can be emptied. A cell can only be emptied if it is between two cells,
-- either horizontally or vertically, and of the two cells one is empty and one is filled.
-- @return boolean

function Cell:canBeEmptied()
    return self.filled and (
        (self.top and self.bottom and (
            (self.top.filled and not self.bottom.filled) or
            (not self.top.filled and self.bottom.filled)
        )) or (self.left and self.right and (
            (self.left.filled and not self.right.filled) or
            (not self.left.filled and self.right.filled)
        ))
    )
end

