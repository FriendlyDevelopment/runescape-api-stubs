---@meta

---@class HTTPRequest
---@field data String Contains the response received from the remote server, or an empty string if the request is pending or has failed.
---@field header String Contains the header received from the remote server, or an empty string if the request is pending or has failed.
---@field cancelled Bool Indicates whether this request has been cancelled by the user.
---@field finished Bool Indicates whether this request has been completed, regardless of whether it succeeded or not.
---@field successful Bool Indicates whether this request has been completed successfully.
---@field failed Bool Indicates whether this request has failed due to an error.
---@field timedOut Bool Indicates whether this request has failed due to not getting a response from the specified target.
---@field responseCode Int HTTP response code received from the target.
---@field errorCode Int HTTP error code received from the target.
---@field errorInfo String If failed is true, this contains additional information regarding the cause of the error.
---@field progress Float? Returns a value in a 0..1 range representing the download progress for this request. If the server does not provide expected download size information, this is instead nil.
---@field url String The address this request is attempting to communicate with.
---@field downloadedBytes Int Number of bytes downloaded from the target so far.
---@field downloadTotalBytes Int Number of bytes expected to be downloaded from the target. Note in some cases this may be 0 despite an in-progress download, as some servers do not provide the necessary information.
HTTPRequest = {}

---Creates a request pointing at a combination of the baseURL and an optional path.
---@param baseURL PluginURL Base URL address to concatenate path to. Specified in the manifest and accessed via the Plugin.urls table.
---@param path String? Optional additional path to concatenate to the baseURL.
---@return HTTPRequest
function HTTPRequest.new(baseURL, path) end

---Triggers a GET / POST request to the remote endpoint specified by this request, and optionally sets up callbacks to track its completion and/or progress.
---@param completionCallback function? (self : HTTPRequest) Callback triggered when this request finishes, regardless of success. Receives this request as its parameter.
---@param progressCallback function? (self : HTTPRequest) Callback triggered whenever this request's download progress changes. Receives this request as its parameter.
function HTTPRequest:Get(completionCallback, progressCallback) end

---@param data String
---@param completionCallback function? (self : HTTPRequest) Callback triggered when this request finishes, regardless of success. Receives this request as its parameter.
---@param progressCallback function? (self : HTTPRequest) Callback triggered whenever this request's download progress changes. Receives this request as its parameter.
function HTTPRequest:Post(data, completionCallback, progressCallback) end

function HTTPRequest:Cancel() end

---@param key String
---@param value String
function HTTPRequest:AddHeader(key, value) end
