---@meta

---@class ui
ui = {}

---@class ui.Slider : ui.Component
---@field value Int The current value for the slider. Note modifying this triggers any potential value hooks set on this component, use SetValue instead if you need to skip those.
---@field valueLabel String The name of the entry associated with the currently selected value, or an empty string if the slider setup didn't include entry names.
---@field minValue Int (Read-only) The minimum value for this slider.
---@field maxValue Int (Read-only) The maximum value for this slider.
---@field numValues Int (Read-only) The number of values available on this slider. This takes into account minValue , maxValue , and rate .
---@field scale Int (Read-only) Divisor applied on the current value when displaying it, allowing integer values to be displayed as floating-point.
---@field rate Int The rate at which the slider transitions from minValue to maxValue . Also used to determine how often notches get displayed on the slider's track.
---@field labelsText ui.TextData (Modifiable Contents) Text properties used when displaying this slider's text labels.
---@field thumbSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the slider's draggable thumb indicator.
---@field trackSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the slider's track.
---@field notchSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the notches on the slider's track.
ui.Slider = {}

---@alias Slider ui.Slider

---Creates a new slider on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this slider in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Slider The newly created slider. The caller must set its layout and visual information afterwards.
function ui.Slider.new(parent, categoryID, dynamicID) end

---Configures the value range for this slider and its current value, returning true if the provided data represents a valid range for a slider.
---@overload fun(self: ui.Slider, min: Int, max: Int, curValue: Int, valueDisplayDivisor: Int, incrementRate: Int): Bool
---@overload fun(self: ui.Slider, entries: String[], selectedValue: Int?): Bool
---@overload fun(self: ui.Slider, entriesMap: table<String, Int>, selectedValue: Int?): Bool
---@param max Int Maximum value for this slider. Must be higher than min .
---@param curValue Int Current value for this slider. Must be between min and max .
---@return Bool True if setup was successful, indicating the slider now has a valid range and is ready to be used.
function ui.Slider:Setup(max, curValue) end

---Sets the current value for this slider.
---@param value Int Desired current value for this slider.
---@param triggerEvents Bool? Whether or not to emit ONSELECTIONCHANGED events for this change. Defaults to false.
---@return Bool True if the provided value is representable by this slider and was set successfully, false otherwise.
function ui.Slider:SetValue(value, triggerEvents) end
