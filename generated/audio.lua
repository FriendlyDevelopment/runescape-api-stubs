---@meta

---Identifies the type of sound associated with a SoundInstance 's playback.Unless otherwise stated, these are just used to categorise sounds and don't affect playback.
---@enum audio.SoundType
audio.SoundType = {
    INVALID = "INVALID", -- 255
    ENTITY = "ENTITY", -- 0
    LOCATION = "LOCATION", -- 1
    LOCATION_RANDOM = "LOCATION_RANDOM", -- 2
    GENERAL_ANIMATION = "GENERAL_ANIMATION", -- 3
    LOCATION_ANIMATION = "LOCATION_ANIMATION", -- 4
    ENTITY_ANIMATION = "ENTITY_ANIMATION", -- 5
    SPOT_ANIMATION = "SPOT_ANIMATION", -- 6
    SCRIPT = "SCRIPT", -- 7
    SERVER_TRIGGERED = "SERVER_TRIGGERED", -- 8
    MUSIC = "MUSIC", -- 9
    JINGLE = "JINGLE", -- 10
    ENTITY_MOVEMENT = "ENTITY_MOVEMENT", -- 11
    INTERFACE_ANIMATION = "INTERFACE_ANIMATION", -- 12
}

---Identifies the audio bus a sound instance is playing into, used by the audio mixer system.These are used to identify certain elements used during audio playback, such as the desired volume based on game settings.
---@enum audio.AudioBus
audio.AudioBus = {
    MASTER = 0,
    SFX = 1,
    MUSIC = 2,
    MUSIC_LOGIC = 3,
    AMBIENT = 4,
    VOICEOVER = 5,
    SFX_SUB = 6,
    MUSIC_SUB = 7,
    DIALOG_SUB = 8,
    PLAYER_ANIMATION_SUB = 9,
    NPC_ANIMATION_SUB = 10,
    LOCATION_ANIMATION_SUB = 11,
    GENERAL_ANIMATION_SUB = 12,
    LOCATIONS_SUB = 13,
    LOCATION_RANDOM_SUB = 14,
    LOCATION_GENERIC_SUB = 15,
}

---Controls how spatial audio applies to this sound instance.
---@enum audio.EmitterShape
audio.EmitterShape = {
    SPHERE = "SPHERE", -- 0
    BOX = "BOX", -- 1
    SPHERE_NO_PANNING = "SPHERE_NO_PANNING", -- 2
    BOX_NO_PANNING = "BOX_NO_PANNING", -- 3
    NONE = "NONE", -- 4
}

---@class audio
audio = {}

---Creates an instance for an audio resource that can then be played back.
---@overload fun(builtinResourceID: Int, params: audio.SoundPlaybackParams?): audio.SoundInstance?
---@param resource PluginAudioResource The plugin-provided audio resource to create a sound instance for.
---@param params audio.SoundPlaybackParams? Parameters used to configure the sound instance. Will use default parameter values if not provided.
---@return audio.SoundInstance? The newly created sound instance, or nil if resource loading or we were already at the maximum number of live sound instances.
function audio.Play(resource, params) end

---Immediately stops playback for the sound instance associated with the provided ID if it exists and is live.
---@param soundInstanceID Int Unique numeric value used to identify the sound instance we're looking to stop playback.
function audio.Stop(soundInstanceID) end

---Stops playback for all sound instances currently using the provided resource.
---@overload fun(builtinResourceID: Int)
---@param resource PluginAudioResource The plugin-provided audio resource to stop playback for.
function audio.StopSoundsUsingResource(resource) end

---SoundInstances represent a single playable sound. By default they're created dormant, and a plugin must then manually call Play on them for playback to start.
---@class audio.SoundInstance
---@field isPlaying Bool True if this sound is currently playing, false otherwise.
---@field isPaused boolean True if this sound is currently paused.
---@field id any Numeric ID used to uniquely identify this sound instance.
audio.SoundInstance = {}

---@alias SoundInstance audio.SoundInstance

---Starts playing this sound instance, or requests playback to start in the specified number of logic ticks.
---@param ticksDelay Int? Optional, indicates how many logic ticks to wait for before this sound starts playing.
function audio.SoundInstance:Start(ticksDelay) end

function audio.SoundInstance:Stop() end

function audio.SoundInstance:Pause() end

function audio.SoundInstance:Resume() end

---@class audio.SoundPlaybackParams
---@field type audio.SoundType The type of this sound. Defaults to audio.SoundType.Script .
---@field numLoops Int How many times this sound should loop for. Defaults to 0, indicating a one-shot sound.
---@field volume Float Volume for this sound's playback relative to its audio bus volume. Defaults to 1.0, representing 100% volume.
---@field audioBus audio.AudioBus The audio bus associated with this sound. Defaults to audio.AudioBus.SFX .
---@field emitterShape audio.EmitterShape The shape used for this sound's spatial audio. Defaults to audio.EmitterShape.none , representing non-spatial audio.
---@field minDistance Float Minimum distance in world units for this sound to be audible. Only relevant for spatial audio. Defaults to 0.
---@field maxDistance Float Maximum distance in world units for this sound to be audible. Only relevant for spatial audio. Defaults to 0.
---@field origin Vector3 Origin in world units for this sound's emitter. Only relevant for spatial audio. Defaults to 0,0,0.
---@field level Int Height level where this sound's playing from. Only relevant for spatial audio. Defaults to -1.
---@field samplingRate Uint Rate at which this audio is sampled. Affects pitch and playback speed. Defaults to 0, indicating the default sample rate (256) should be used instead.
---@field delayTick Int The number of logic ticks to delay playback for. Defaults to 0, indicating immediate playback.
audio.SoundPlaybackParams = {}

---@alias SoundPlaybackParams audio.SoundPlaybackParams

---@return audio.SoundPlaybackParams
function audio.SoundPlaybackParams.new() end
