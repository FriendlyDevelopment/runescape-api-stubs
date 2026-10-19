---@meta

---Identifies what inputs will be handled by an InputField component.
---@enum ui.InputFieldKeyHandlingMode
ui.InputFieldKeyHandlingMode = {
    DEFAULT = "DEFAULT", -- Handles all inputs.
    CHAT = "CHAT", -- Ignores keyboard arrow key inputs.
}

---Contains the available filter modes for filtering user inputs written to an InputField component.
---@enum ui.InputFieldFilterMode
ui.InputFieldFilterMode = {
    NONE = "NONE", -- No filtering, all inputs allowed.
    ALPHANUMERIC = "ALPHANUMERIC", -- No symbol inputs allowed.
    NUMERIC = "NUMERIC", -- Only numbers allowed.
    QUANTITY = "QUANTITY", -- Only allows numbers and english quantity designators (eg. 1K representing 1000 , 1M representing 1000000 ).
    NUMBERS_AS_TEXT = "NUMBERS_AS_TEXT", -- Only numbers allowed, with the resulting number always being represented as a string.
}

---Contains the potential result type for the most recent input action on an InputField component.
---@enum ui.InputFieldActionResult
ui.InputFieldActionResult = {
    NONE = "NONE", -- No recent input actions.
    ERROR = "ERROR", -- An error occurred during the latest input action.
    CONTENT_CHANGE = "CONTENT_CHANGE", -- The InputField's contents have changed due to the latest input action.
    SUBMIT = "SUBMIT", -- The latest input action was a submit request, triggered by the user pressing the Enter key.
    SUBMIT_ON_ESCAPE = "SUBMIT_ON_ESCAPE", -- The latest input action may be treated as a submit request, triggered by the user pressing the Esc key.
    SUBMIT_ON_FOCUS_LOSS = "SUBMIT_ON_FOCUS_LOSS", -- The latest input action may be treated as a submit request, triggered by the InputField losing focus due to the user clicking elsewhere.
}

---Contains the visibility modes available for text in InputFields.
---@enum ui.TextContentVisibilityMode
ui.TextContentVisibilityMode = {
    VISIBLE = "VISIBLE", -- Text is always visible.
    SHOW_LAST = "SHOW_LAST", -- All text other than the last character is hidden, replaced by * characters.
    HIDDEN = "HIDDEN", -- All text is replaced by * characters.
}

---@class ui
ui = {}

---@class ui.InputField : ui.Component
---@field content String Gets or sets the current contents of the input field. If the component is restricted, attempting to retrieve the contents will yield an empty string.
---@field contentQuantity Int? (Read-only) Attempts to convert the current contents into an integer and returns it if successful. Only usable with numeric and quantity input fields.
---@field visibility ui.TextContentVisibilityMode Identifies how text will be drawn for this input field.
---@field filterMode ui.InputFieldFilterMode Identifies how inputs will be filtered by this input field.
---@field maxLength Int (Read-only) The maximum number of characters that are allowed in this input field.
---@field inputMode ui.InputFieldKeyHandlingMode Identifies how inputs will be handled by this input field.
---@field emptyText String Text to be displayed while this input field is empty.
---@field caretColour Vector4 Colour used for the cursor.
---@field caretRGBA Uint Hex-encoded red/green/blue/alpha colour code for the cursor.
---@field errorCaretColour Vector4 Colour used for the cursor when an error occurs.
---@field errorCaretRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the cursor when an error occurs.
---@field selectionHighlightColour Vector4 Colour used for the text selection overlay.
---@field selectionHighlightRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the text selection overlay.
---@field emptyTextColour Vector4 Colour used for the text displayed while the input field is empty.
---@field emptyTextRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the text displayed while the input field is empty.
---@field contentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component.
---@field text ui.TextData (Modifiable Contents) Text properties used when displaying this input field. Note using text.content will not yield the actual contents of the input field, and you must instead use the content property present on the input field itself.
---@field containerSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
---@field scrollbar ui.ScrollBar (Modifiable Contents) Scroll bar proprties used when vertical scrolling is required.
ui.InputField = {}

---@alias InputField ui.InputField

---Creates a new input field on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this input field in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return InputField # The newly created input field. The caller must set its layout and visual information afterwards.
function ui.InputField.new(parent, categoryID, dynamicID) end

---Sets text handling and content drawing properties for this input field.
---@param visibility ui.TextContentVisibilityMode How the contents should be displayed to the user.
---@param filter ui.InputFieldFilterMode How inputs should be filtered, if at all.
---@param maxLength Int The maximum number of characters allowed.
function ui.InputField:Setup(visibility, filter, maxLength) end
