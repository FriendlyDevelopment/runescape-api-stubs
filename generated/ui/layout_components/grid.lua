---@meta

---@class ui
ui = {}

---@class ui.Grid : ui.ComponentCollection
---@field cellWidth Int (Read-only) The width of each cell in this grid.
---@field cellHeight Int (Read-only) The height of each cell in this grid.
---@field columns Int (Read-only) The number of columns in this grid.
---@field rows Int (Read-only) The number of rows in this grid.
---@field hasFixedCellSizes Bool (Read-only) Indicates whether the cell size for this grid has been explicitly set via SetCellSize , resulting in dynamically calculated columns and rows values based on the grid's dimensions. Otherwise it's cellWidth and cellHeight that are dynamically calculated.
---@field spacing Int The spacing in interface units between grid cells, both horizontal and vertical.
ui.Grid = {}

---@alias Grid ui.Grid

---Creates a new Grid on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this grid in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Grid The newly created grid. The caller must set its layout and visual information afterwards.
function ui.Grid.new(parent, categoryID, dynamicID) end

---Makes the grid use a fixed number of columns and rows, and dynamically scales cell sizes based on that and the grid's dimensions.
---@param columns Int The desired number of columns to use for this grid.
---@param rows Int The desired number of rows to use for this grid.
function ui.Grid:SetColumnRows(columns, rows) end

---Makes the grid use fixed cell dimensions, and dynamically scales the number of columns and rows available based on that and the grid's dimensions.
---@param width Int The desired width of each cell to use for this grid.
---@param height Int The desired height of each cell to use for this grid.
function ui.Grid:SetCellSize(width, height) end
