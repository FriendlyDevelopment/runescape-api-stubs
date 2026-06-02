---@meta

---Enumeration containing the various options for how the previous/next page carousel buttons should be displayed.
---@enum ui.CarouselButtonDisplayMode
ui.CarouselButtonDisplayMode = {
    SIDES = "SIDES", -- Indicates the carousel's buttons should be displayed on its left and right sides.
}

---@class ui
ui = {}

---@class ui.PagedCarousel : ui.PagedLayer
---@field isSinglePageDisplay Bool (Read-only) True if this paged carousel only displays one page at the time, with no others being partially visible.
---@field numFullyVisiblePages Int (Read-only) The number of pages that can be viewed in their entirety at the same time.
---@field isSwitchingPages Bool (Read-only) * ** True if a page switch animation is currently in progres.
---@field pageSpacing Int Spacing in interface units between each displayed page.
---@field inactivePageVisibility Float Indicates how many pages can be displayed besides the one currently in focus. This value is symmetrical, so a value of 0.5 means 50% of the previous and 50% of the next page are visible. Supports multiple pages, for example 1.5 results in one additional fully visible page to each side, followed by another 50% visible page on each side.
---@field inactivePageScale Float Fractional height scaling used for inactive pages compared to the focused page. Defaults to 1.0, the same size as the focused page. Avoid using too high or too low values, as it may affect page contents negatively as well as cause issues with the transition animations.
---@field inactivePageReceiveInput Bool Controls whether inactive pages can be interacted with. Not recommended when inactivePageVisibility contains fractional values as it may be confusing to users.
---@field inactivePageFadeRegionSize Uint16 Controls the width in interface units of the gradient fade on the left and right edges of the paged carousel. Set to 0 to remove the fade effect.
---@field buttonWidth Uint16 Width used for the previous/next page buttons.
---@field buttonHeight Uint16 Height used for the previous/next page buttons.
---@field buttonDisplayMode ui.CarouselButtonDisplayMode Controls how the previous/next buttons are displayed.
---@field buttonSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the previous/next buttons.
---@field pageBackgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used each page's background.
---@field pageContentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for each page.
ui.PagedCarousel = {}

---@alias PagedCarousel ui.PagedCarousel

---Creates a new PagedCarousel on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this paged carousel in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return PagedCarousel The newly created paged carousel. The caller must set its layout and visual information afterwards.
function ui.PagedCarousel.new(parent, categoryID, dynamicID) end
