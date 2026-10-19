---@meta

---@class FontType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "MUSEO_SANS_15PT_REGULAR" .
---@field typeName String The type of this config. Will always be "Font" .
---@field baseline Int The baseline distance of the font. This is also the vertical spacing between lines.
---@field upperCaseAscent Int The distance above the baseline for the uppercase 'X' glyph in the font.
---@field lowerCaseAscent Int The distance above the baseline for the lowercase 'x' glyph in the font.
---@field maxAscent Int The maximum distance above the baseline for the tallest glyph in the font.
---@field maxDescent Int The maximum distance below the baseline for the lowest glyph in the font.
local Font = {}

---Returns the pixel width of a string drawn with this font.
---@param text String The text to calculate the total pixel width for.
---@param ignoreTags Bool? See Common Modifiers .
---@return Int # The total pixel width of the given string when drawn with this font.
function Font:GetStringWidth(text, ignoreTags) end

---Returns the pixel width of a wrapped multiline string drawn with this font.
---@param text String The text to calculate the pixel width for.
---@param wrapWidth Int The pixel width limit at which the string should wrap.
---@param ignoreTags Bool? See Common Modifiers .
---@param noWordWrapping Bool? See Common Modifiers .
---@param noTrimEdges Bool? See Common Modifiers .
---@return Int # The total pixel width of the longest line after wrapping this given string into multiple lines.
function Font:GetStringWidthMultiline(text, wrapWidth, ignoreTags, noWordWrapping, noTrimEdges) end

---Returns how many lines the given string will be become when wrapped using this font.
---@param text String The text to calculate the line count for.
---@param wrapWidth Int The pixel width limit at which the string should wrap.
---@param ignoreTags Bool? See Common Modifiers .
---@param noWordWrapping Bool? See Common Modifiers .
---@param noTrimEdges Bool? See Common Modifiers .
---@return Int # The total number of lines resulting after wrapping the given string using this font.
function Font:GetStringLineCount(text, wrapWidth, ignoreTags, noWordWrapping, noTrimEdges) end

---Returns the total pixel height of a string wrapped using this font and how many lines the text was wrapped into.
---@param text String The text to calculate the height and line count for.
---@param wrapWidth Int The pixel width limit at which the string should wrap.
---@param lineSpacing Int The pixel spacing between each line. This is the distance between the baselines of each line.
---@param ignoreTags Bool? See Common Modifiers .
---@param noWordWrapping Bool? See Common Modifiers .
---@param noTrimEdges Bool? See Common Modifiers .
---@return Int # The total pixel height after wrapping this given string into multiple lines.
---@return Int # The total number of lines resulting after wrapping the given string using this font.
function Font:GetStringHeightAndLineCount(text, wrapWidth, lineSpacing, ignoreTags, noWordWrapping, noTrimEdges) end

---Splits the given string using the given pixel wrap distance and returns the resulting strings.
---@param text String The text to split.
---@param wrapWidth Int The pixel width limit at which the string should split.
---@param ignoreTags Bool? See Common Modifiers .
---@param noWordWrapping Bool? See Common Modifiers .
---@param noTrimEdges Bool? See Common Modifiers .
---@return String[] # The resulting strings after spliting the given string.
function Font:SplitString(text, wrapWidth, ignoreTags, noWordWrapping, noTrimEdges) end

---Splits the given string using the given pixel wrap distance and returns the specific line requested.
---@param text String The text to split.
---@param lineIndex Int The index of the requested line. Line numbers are 1-indexed. Requesting a line index greater than available will return an empty string.
---@param wrapWidth Int The pixel width limit at which the string should split.
---@param ignoreTags Bool? See Common Modifiers .
---@param noWordWrapping Bool? See Common Modifiers .
---@param noTrimEdges Bool? See Common Modifiers .
---@return String # The requested line after spliting the given string.
function Font:GetSplitStringLine(text, lineIndex, wrapWidth, ignoreTags, noWordWrapping, noTrimEdges) end
