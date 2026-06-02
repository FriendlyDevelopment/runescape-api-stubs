---@meta

---Identifies the type of sound associated with a SoundInstance 's playback. Unless otherwise stated, these are just used to categorise sounds and don't affect playback.
---@enum audio.SoundType
audio.SoundType = {
    invalid = "invalid",
    entity = "entity",
    location = "location",
    location_random = "location_random",
    generalAnimation = "generalAnimation",
    locationAnimation = "locationAnimation",
    entityAnimation = "entityAnimation",
    spotAnimation = "spotAnimation",
    script = "script",
    serverTriggered = "serverTriggered",
    music = "music", -- Identifies a sound meant to be played as music. Playback for audio of this type cannot be manually stopped.
    jingle = "jingle", -- Identifies a sound meant to be played as a short jingle. Playback for audio of this type cannot be manually stopped.
    entityMovement = "entityMovement",
    interfaceAnimation = "interfaceAnimation",
}

---Identifies the audio bus a sound instance is playing into, used by the audio mixer system. These are used to identify certain elements used during audio playback, such as the desired volume based on game settings.
---@enum audio.AudioBus
audio.AudioBus = {
    master = "master",
    sfx = "sfx",
    music = "music",
    musicLogin = "musicLogin",
    ambient = "ambient",
    voiceover = "voiceover",
    dialog = "dialog",
    playerAnimation = "playerAnimation",
    npcAnimation = "npcAnimation",
    locationAnimation = "locationAnimation",
    generalAnimation = "generalAnimation",
    locations = "locations",
    locationRandom = "locationRandom",
    locationGeneric = "locationGeneric",
}

---Controls how spatial audio applies to this sound instance.
---@enum audio.EmitterShape
audio.EmitterShape = {
    sphere = "sphere", -- The sound's volume scales based on distance between the emitter and the listener, and takes into account the angle between them. Represents a spherical volume.
    box = "box", -- The sound's volume scales based on distance between the emitter and the listener, and takes into account the angle between them. Represents a box volume.
    sphereNoPanning = "sphereNoPanning", -- The sound's volume scales based on distance between the emitter and the listener, ignoring the angle between them. Represents a spherical volume.
    boxNoPanning = "boxNoPanning", -- The sound's volume scales based on distance between the emitter and the listener, ignoring the angle between them. Represents a box volume.
    none = "none", -- The emitter doesn't use spatial audio.
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
