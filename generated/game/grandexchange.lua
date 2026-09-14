---@meta

---Type of offer for a offer on the Grand Exchange.
---@enum GrandExchangeOfferType
GrandExchangeOfferType = {
    BUY = 0,
    SELL = 1,
}

---Repesentation of a stage for a offer on the Grand Exchange.
---@enum GrandExchangeOfferStage
GrandExchangeOfferStage = {
    EMPTY = 0,
    ADDING = 1,
    ADDED = 2,
    VERIFYING = 3,
    ABORTING = 4,
    FINISHED = 5,
}

---@class GrandExchange
GrandExchange = {}

---A representation of an offer on the Grand Exchange.
---@class GrandExchangeOffer
---@field stage GrandExchangeOfferStage The stage the offer has reached.
---@field type GrandExchangeOfferType The type of offer.
---@field item ObjType The item associated with the offer.
---@field price Int The gold price per individual item.
---@field itemCount Int Number of items in the offer.
---@field soldCount Int Number of items that have been sold in the offer.
---@field goldFromSale Int Amount of gold available after some items have been bought/sold.
GrandExchangeOffer = {}
