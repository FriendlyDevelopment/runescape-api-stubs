---@meta

---Bitfield values for use in testing combined modifier values provided in key events:
---@enum ModifierKey
ModifierKey = {
    SHIFT = 1,
    CONTROL = 2,
    ALT = 4,
    META = 8,
    ANY = 7,
    ANY_INC_META = 15,
}

---@enum GameKey
GameKey = {
    F1 = 1,
    F2 = 2,
    F3 = 3,
    F4 = 4,
    F5 = 5,
    F6 = 6,
    F7 = 7,
    F8 = 8,
    F9 = 9,
    F10 = 10,
    F11 = 11,
    F12 = 12,
    ESCAPE = 13,
    _1 = 16,
    _2 = 17,
    _3 = 18,
    _4 = 19,
    _5 = 20,
    _6 = 21,
    _7 = 22,
    _8 = 23,
    _9 = 24,
    _0 = 25,
    MINUS = 26,
    EQUALS = 27,
    CONSOLE = 28,
    Q = 32,
    W = 33,
    E = 34,
    R = 35,
    T = 36,
    Y = 37,
    U = 38,
    I = 39,
    O = 40,
    P = 41,
    LEFT_BRACKET = 42,
    RIGHT_BRACKET = 43,
    A = 48,
    S = 49,
    D = 50,
    F = 51,
    G = 52,
    H = 53,
    J = 54,
    K = 55,
    L = 56,
    SEMICOLON = 57,
    APOSTROPHE = 58,
    HASH = 59,
    Z = 64,
    X = 65,
    C = 66,
    V = 67,
    B = 68,
    N = 69,
    M = 70,
    COMMA = 71,
    FULLSTOP = 72,
    SLASH = 73,
    BACKSLASH = 74,
    TAB = 80,
    SHIFT = 81,
    CONTROL = 82,
    SPACE = 83,
    ENTER = 84,
    BACKSPACE = 85,
    ALT = 86,
    NUMPAD_ADD = 87,
    NUMPAD_SUBTRACT = 88,
    NUMPAD_MULTIPLY = 89,
    NUMPAD_DIVIDE = 90,
    CLEAR = 91,
    LEFT = 96,
    RIGHT = 97,
    UP = 98,
    DOWN = 99,
    INSERT = 100,
    DELETE = 101,
    HOME = 102,
    END = 103,
    PAGE_UP = 104,
    PAGE_DOWN = 105,
}

---@enum SystemKey
SystemKey = {
    BACKSPACE = 8,
    TAB = 9,
    CLEAR = 12,
    RETURN = 13,
    ENTER = 13,
    SHIFT_LEFT = 16,
    CONTROL_LEFT = 17,
    ALT_LEFT = 18,
    ESCAPE = 27,
    SPACE = 32,
    PAGE_UP = 33,
    PAGE_DOWN = 34,
    END = 35,
    HOME = 36,
    LEFT = 37,
    UP = 38,
    RIGHT = 39,
    DOWN = 40,
    INSERT = 45,
    DELETE = 46,
    _0 = 48,
    _1 = 49,
    _2 = 50,
    _3 = 51,
    _4 = 52,
    _5 = 53,
    _6 = 54,
    _7 = 55,
    _8 = 56,
    _9 = 57,
    A = 65,
    B = 66,
    C = 67,
    D = 68,
    E = 69,
    F = 70,
    G = 71,
    H = 72,
    I = 73,
    J = 74,
    K = 75,
    L = 76,
    M = 77,
    N = 78,
    O = 79,
    P = 80,
    Q = 81,
    R = 82,
    S = 83,
    T = 84,
    U = 85,
    V = 86,
    W = 87,
    X = 88,
    Y = 89,
    Z = 90,
    NUMPAD_MULTIPLY = 106,
    NUMPAD_ADD = 107,
    NUMPAD_SUBTRACT = 109,
    NUMPAD_DECIMAL = 110,
    NUMPAD_DIVIDE = 111,
    F1 = 112,
    F2 = 113,
    F3 = 114,
    F4 = 115,
    F5 = 116,
    F6 = 117,
    F7 = 118,
    F8 = 119,
    F9 = 120,
    F10 = 121,
    F11 = 122,
    F12 = 123,
    SEMICOLON = 186,
    EQUALS = 187,
    COMMA = 188,
    MINUS = 189,
    FULLSTOP = 190,
    SLASH = 191,
    APOSTROPHE = 192,
    LEFT_BRACKET = 219,
    BACKSLASH = 220,
    RIGHT_BRACKET = 221,
    HASH = 222,
    CONSOLE = 7331,
}

---@class Keyboard
Keyboard = {}

---Returns whether keyboard data is available on the current platform.
---@return Bool Whether keyboard data can be polled on the current platform.Returns false on Mobile devices, and true on all others.
function Keyboard.IsAvailable() end

---Returns whether keyboard data is being blocked by the game for any reason. This can occur when an InputField is set as restricted and is current in focus.
---@return Bool Whether accessing keyboard data is blocked at the current moment.Returns true when data is unavailable, and false when it is available.
function Keyboard.IsBlocked() end

---Returns whether either shift key is currently down.
---@return Bool The current shift key down state.Returns false if keyboard data is blocked .
function Keyboard.IsShiftDown() end

---Returns whether either control/ctrl key is currently down.
---@return Bool The current control key down state.Returns false if keyboard data is blocked .
function Keyboard.IsControlDown() end

---Returns whether either alt key is currently down.
---@return Bool The current alt key down state.Returns false if keyboard data is blocked .
function Keyboard.IsAltDown() end

---Returns whether either meta key is currently down.
---@return Bool The current meta key down state.Returns false if keyboard data is blocked .
function Keyboard.IsMetaDown() end

---Returns whether the given GameKey key is currently down.
---@param key GameKey Integer enum value for the key being tested.
---@return Bool The current key down state.Returns false if keyboard data is blocked .
function Keyboard.IsGameKeyDown(key) end

---Returns all currently pressed GameKeys in an array.
---@return GameKey[] An array of GameKeys .
function Keyboard.GetGameKeysDown() end
