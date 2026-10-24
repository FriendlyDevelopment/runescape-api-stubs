---@meta

---@enum MapElementHorizontalAlign
MapElementHorizontalAlign = {
    LEFT = "LEFT", -- 0
    CENTRE = "CENTRE", -- 1
    RIGHT = "RIGHT", -- 2
}

---@enum MapElementVerticalAlign
MapElementVerticalAlign = {
    TOP = "TOP", -- 0
    CENTRE = "CENTRE", -- 1
    BOTTOM = "BOTTOM", -- 2
}

---@enum MapElementTextSize
MapElementTextSize = {
    SMALL = "SMALL", -- 0
    MEDIUM = "MEDIUM", -- 1
    LARGE = "LARGE", -- 2
}

---@class MapElementType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "DINO_GAME_ICON_1" .
---@field typeName String The type of this config. Will always be "MapElement" .
---@field listable Bool Is this config listable.
---@field spriteID Int The ID of the sprite associated with the MapElement.
---@field spriteMouseOverID Int The ID of the sprite associated with the MapElement when a mouse hovers over it on the map.
---@field text String The text displayed for this element on the map.
---@field textColour Vector4 The colour of the text displayed on the map.
---@field textRGBA Int The colour of the text displayed on the map as an integer.
---@field textMouseOverColour Vector4 The colour of the text displayed on the when a mouse hovers over it on the map.
---@field textMouseOverRGBA Int The colour of the text displayed on the when a mouse hovers over it on the map as an integer.
---@field textSize MapElementTextSize The text size used to display the element's text on the map.
---@field textOffsetX Int The text offset on the X-axis used when displaying the element's text on the map.
---@field textOffsetZ Int The text offset on the Z-axis used when displaying the element's text on the map.
---@field textBGFillColour Vector4 The colour of the background for the text displayed on the map.
---@field textBGFillRGBA Int The colour of the background for the text displayed on the map as an integer.
---@field textBGOutlineColour Vector4 The colour of the background for the text displayed on the map.
---@field textBGOutlineRGBA Int The colour of the background outline for the text displayed on the when a mouse hovers over it on the map as an integer.
---@field showOnMiniMap Bool Is this config displayed on the minimap.
---@field showOnWorldMap Bool Is this config displayed on the world map.
---@field category Int The MapElement category this config is associated with.
---@field subjectText String The text for the world map subject for the associated MapElement.
---@field flashSpriteID Int The ID of the sprite associated with the MapElement when flashing on the map.
---@field minimapIconScale Int The icon scaling for the MapElement used when rendering it to the minimap.
---@field alignHorizontal MapElementHorizontalAlign The horizontal alignment of the MapElement.
---@field alignVertical MapElementVerticalAlign The vertical alignment of the MapElement.
---@field isMultiMapElement Bool Whether this config contains a sub-list of MapElementTypes, of which one is selected based on a variable check.
local MapElement = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any # The corresponding output value. Returns param.defaultValue if the param is not found in the data structure.
function MapElement:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool # Whether a corresponding value exists in this config for ParamType .
function MapElement:HasParam(param) end
