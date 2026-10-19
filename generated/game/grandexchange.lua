---@meta

---@enum GrandExchangeOfferType
GrandExchangeOfferType = {
    BUY = 0,
    SELL = 1,
}

---@enum GrandExchangeOfferStage
GrandExchangeOfferStage = {
    EMPTY = 0,
    ADDING = 1,
    ADDED = 2,
    VERIFYING = 3,
    ABORTING = 4,
    FINISHED = 5,
}

---@class GrandExchangeOffer
---@field stage GrandExchangeOfferStage The stage the offer has reached.
---@field type GrandExchangeOfferType The type of offer.
---@field item ObjType The item associated with the offer.
---@field price Int The gold price per individual item.
---@field itemCount Int Number of items in the offer.
---@field soldCount Int Number of items that have been sold in the offer.
---@field goldFromSale Int Amount of gold available after some items have been bought/sold.
GrandExchangeOffer = {}

---@class GrandExchange
GrandExchange = {}

---@param slot Int 1-indexed slot number.
---@return GrandExchangeOffer? # The offer in the specified slot, or nil if the slot cannot be found.
function GrandExchange.GetOffer(slot) end

---@return Int # The maximum number of offers a player can have on the Grand Exchange.
function GrandExchange.MaxOffers() end
