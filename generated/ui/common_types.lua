---@meta

---Enumeration representing a component's type.
---@enum ui.ComponentType
ui.ComponentType = {
    LINE = "LINE", -- A line component.
    RECTANGLE = "RECTANGLE", -- A rectangle component.
    LABEL = "LABEL", -- A text component.
    SPRITE = "SPRITE", -- A sprite component.
    MODEL = "MODEL", -- A model component.
    MODEL_GROUP = "MODEL_GROUP", -- A model group component.
    RADIAL_PROGRESS_OVERLAY = "RADIAL_PROGRESS_OVERLAY", -- A radial progress overlay component.
    CUTSCENE_LAYER = "CUTSCENE_LAYER", -- A cutscene layer component.
    CANVAS = "CANVAS", -- A canvas component.
    BUTTON = "BUTTON", -- A button component.
    CHECK = "CHECK", -- A check component.
    LIST = "LIST", -- A list component.
    INPUTFIELD = "INPUTFIELD", -- An input field component.
    SLIDER = "SLIDER", -- A slider component.
    COMBO = "COMBO", -- A combo field component.
    PAGED_LAYER_HEADER = "PAGED_LAYER_HEADER", -- A paged layer header component.
    CAROUSEL = "CAROUSEL", -- A carousel component.
    PAGED_CAROUSEL = "PAGED_CAROUSEL", -- A paged carousel component.
    RADIO_GROUP = "RADIO_GROUP", -- A radio group component.
    LAYER = "LAYER", -- A layer component.
    PANEL = "PANEL", -- A panel component.
    GRID = "GRID", -- A grid component.
    PAGED_LAYER = "PAGED_LAYER", -- A paged layer component.
    GROUP_BOX = "GROUP_BOX", -- A groupbox component.
}

---Enumeration identifying how an element should be aligned.
---@enum ui.AlignMode
ui.AlignMode = {
    TOPLEFT = "TOPLEFT", -- This element will be aligned to the top-left corner.
    CENTRE = "CENTRE", -- This element will be aligned to the centre.
    BOTTOMRIGHT = "BOTTOMRIGHT", -- This element will be aligned to the bottom-right corner.
    JUSTIFY = "JUSTIFY", -- This element will be aligned to the top-left corner, and justified so as to occupy the full width if possible.
}

---Enumeration identifying how an element should be scaled based on its aspect ratio.
---@enum ui.AspectRatioMode
ui.AspectRatioMode = {
    NO_SCALING = "NO_SCALING", -- This element will ignore aspect ratio settings.
    SCALE_WIDTH = "SCALE_WIDTH", -- This element will stretch horizontally so it matches its target aspect ratio.
    SCALE_HEIGHT = "SCALE_HEIGHT", -- This element will stretch vertically so it matches its target aspect ratio.
}

---@class ui.TextDataConfig
ui.TextDataConfig = {}

---@alias TextDataConfig ui.TextDataConfig

---@class ui.SpriteDataConfig
ui.SpriteDataConfig = {}

---@alias SpriteDataConfig ui.SpriteDataConfig

---@class ui
ui = {}

---Used to represent positions, taking into account absolute horizontal and vertical offsets, as well as a specific percent of an arbitrary parent component's width and height, and a component's own width and height.
---@class ui.Pos
---@field x Int Horizontal offset in interface units.
---@field y Int Vertical offset in interface units.
---@field xParentPc Float Percentage of the parent component's width to take into account for positioning.
---@field yParentPc Float Percentage of the parent component's height to take into account for positioning.
---@field xSelfPc Float Percentage of the component's width to take into account for positioning.
---@field ySelfPc Float Percentage of the component's height to take into account for positioning.
ui.Pos = {}

---@alias Pos ui.Pos

---Creates a new position object.
---@overload fun(other: Pos): Pos
---@overload fun(x: Int, y: Int): Pos
---@overload fun(x: Int, y: Int, xParentPc: Float, yParentPc: Float): Pos
---@overload fun(x: Int, y: Int, xParentPc: Float, yParentPc: Float, xSelfPc: Float, ySelfPc: Float): Pos
---@return Pos The newly created position object.
function ui.Pos.new() end

---Used to represent sizes, taking into account absolute horizontal and vertical offsets, as well as a specific percent of an arbitrary parent component's width and height, as well of a component's own width and height.
---@class ui.Size
---@field width Int Width offset in interface units.
---@field height Int Height offset in interface units.
---@field widthParentPc Float Percentage of the parent component's width to take into account for sizing.
---@field heightParentPc Float Percentage of the parent component's height to take into account for sizing.
ui.Size = {}

---@alias Size ui.Size

---Creates a new position object.
---@overload fun(other: Size): Size
---@overload fun(width: Int, height: Int): Size
---@overload fun(width: Int, height: Int, widthParentPc: Float, heightParentPc: Float): Size
---@return Size The newly created size object.
function ui.Size.new() end

---Used to represent a text element within a UI component. These contain properties necessary for drawing text, as well as the actual text to draw.
---@class ui.TextData
---@field content String The text to draw.
---@field font Int The font to use when drawing this text.
---@field lineSpacing Uint8 Spacing between text lines in interface units. Defaults to the font's spacing if set to zero.
---@field alignHorizontal ui.AlignMode Horizontal alignment for this text.
---@field alignVertical ui.AlignMode Vertical alignment for this text.
---@field maxLines Uint8 Maximum number of lines to display. Can be set to 0 to allow an unlimited number of lines.
---@field alpha Float Visibility for this text, ranging from 0 (fully transparent) to 1 (opaque).
---@field colour Vector4 Colour used when drawing this text.
---@field rgba Uint Hex-encoded red/green/blue/alpha colour code used when drawing this text.
---@field shadowColour Vector4 Colour used when drawing this text's shadow if enabled.
---@field shadowRGBA Uint Hex-encoded red/green/blue/alpha colour code used when drawing this text's shadow if enabled.
---@field isShadowed Bool Whether or not to draw this text with a shadow effect for better legibility. Defaults to false.
ui.TextData = {}

---@alias TextData ui.TextData

---Sets the alignment for this text.
---@overload fun(self: ui.TextData, horizontalAlignment: ui.AlignMode, verticalAlignment: ui.AlignMode): ui.TextDataConfig
---@param alignment ui.AlignMode The alignment to set as both horizontal and vertical alignments.
---@return ui.TextDataConfig Config containing a copy of all properties set on this TextData object, excluding non-config properties (eg. content )
function ui.TextData:AlignTo(alignment) end

---@param config ui.TextDataConfig The config to source the various properties from.
---@return ui.TextDataConfig Config containing a copy of all properties set on this TextData object, excluding non-config properties (eg. content )
function ui.TextData:SetConfig(config) end

---@return ui.TextDataConfig Config containing a copy of all properties set on this TextData object, excluding non-config properties (eg. content )
function ui.TextData:GetConfigCopy() end

---Used to represent a sprite element within a UI component. These contain properties necessary for drawing sprite, as well as the actual sprite resource to draw.
---@class ui.SpriteData
---@field sprite Int RuntimeSprite
---@field spriteID Int Gets the built-in sprite ID to draw.
---@field runtimeSprite RuntimeSprite Gets the current runtime sprite to draw or nil if it doesn't exist.
---@field visualMargins ui.Margin (Modifiable Contents) Offsets used to split this sprite's graphics into multiple segments for drawing. See image layout for information on how they're used.
---@field outlineWidth Uint8 Thickness of the sprite's outline. Only used when the containing component is associated with an object.
---@field rotationRadians Float Rotation of this sprite in radians.
---@field rotationDegrees Float Rotation of this sprite in degrees.
---@field alpha Float Visibility for this sprite, ranging from 0 (fully transparent) to 1 (opaque).
---@field colour Vector4 Colour used when drawing this sprite.
---@field rgba Uint Hex-encoded red/green/blue/alpha colour code used when drawing this sprite.
---@field shadowColour Vector4 Colour used when drawing this sprite's shadow. If alpha is 0, no shadow will be drawn.
---@field shadowRGBA Uint Hex-encoded red/green/blue/alpha colour code used when drawing this sprite. If alpha is 0, no shadow will be drawn.
---@field isFlippedHorizontally Bool Flag indicating whether or not this sprite is drawn mirrored horizontally.
---@field isFlippedVertical Bool Flag indicating whether or not this sprite is drawn mirrored vertical.
---@field isTiling Bool Flag indicating whether or not this sprite uses tiled visuals.
ui.SpriteData = {}

---@alias SpriteData ui.SpriteData

---Sets this SpriteData's properties based on the provided config values.
---@param config ui.SpriteDataConfig The config to source the various properties from.
---@return ui.SpriteDataConfig Config containing a copy of all properties set on this SpriteData object, excluding non-config properties (eg. content )
function ui.SpriteData:SetConfig(config) end

---@return ui.SpriteDataConfig Config containing a copy of all properties set on this SpriteData object, excluding non-config properties (eg. content )
function ui.SpriteData:GetConfigCopy() end

---Margins are used to represent distances from the sides of a region.
---@class ui.Margin
---@field left Uint8 Distance from the left edge in interface units for this margin.
---@field top Uint8 Distance from the top edge in interface units for this margin.
---@field right Uint8 Distance from the right edge in interface units for this margin.
---@field bottom Uint8 Distance from the bottom edge in interface units for this margin.
ui.Margin = {}

---@alias Margin ui.Margin

---Constructs a new margin object with the provided values, or with all sides initialised to zero if omitted.
---@overload fun(allSides: uint8): Margin
---@overload fun(left: uint8, top: uint8, right: uint8, bottom: uint8): Margin
---@return Margin Resulting margin object.
function ui.Margin.new() end

---Provides controls for scrolling a component's contents.
---@class ui.ScrollBar
---@field size Uint8 The scrollbar's size, representing width or height depending on whether it's a vertical or a horizontal scrollbar, respectively.
---@field visible Bool Controls whether the scrollbar is visible or not. Defaults to true.
---@field autohide Bool Controls whether the scrollbar only appears to the user when required by the component where the scrollbar resides. For example, an input field may hide the scrollbar until the contents exceed the input field's visible region. Note this doesn't affect the value of visible , as that controls whether the scrollbar can ever appear to the user. Defaults to true.
---@field buttonLength Uint8 The length of the scrollbar's buttons, representing height or width depending on whether it's a vertical or a horizontal scrollbar. Can be set to 0 to remove the buttons.
---@field backgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
---@field buttonSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the scrollbar's buttons.
---@field handleSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the scrollbar's draggable handle.
ui.ScrollBar = {}

---@alias ScrollBar ui.ScrollBar
