---@meta

---Identifies why a cutscene finished playing on a cutscene layer component.
---@enum ui.CutscenePlaybackEndReason
ui.CutscenePlaybackEndReason = {
    FINISHED = "FINISHED", -- The cutscene finished playing normally.
    CANCELLED = "CANCELLED", -- Playback was manually cancelled by the user.
    INTERRUPTED = "INTERRUPTED", -- The cutscene was interrupted by another cutscene.
    INTERFACE_CLOSED = "INTERFACE_CLOSED", -- The cutscene's playback was interrupt due to the interface in which its layer resided being closed.
}
