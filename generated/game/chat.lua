---@meta

---Provides functions that access and manipulate chat data.
---Requires the chatAccess permission in the plugin manifest.
---@class Chat
Chat = {}

---Adds a message to the chat window, visible only to the local Player Character and not transmitted.
---Messages are queued until the next logic update and trigger Event.ChatMessage with ChatType.PLUGIN.
---@param message String Message string that will be posted to the chat window.
function Chat.AddMessage(message) end
