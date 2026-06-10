#  LuaLS Stubs for the RuneScape API

This repository generates LuaLS stubs for the RuneScape API.

## Usage

To use the stubs, clone the repository and put it next to your Lua project.
Then use the `.luarc.json` file in your project, pointing to the stubs.

So your project structure should look like this:

```
- MyLuaProject
  - .luarc.json
  - main.lua
- runescape-api-stubs
```

## Usage - Constants

If you also want to have type hints for the constants, like NPC IDs, Obj IDs, etc. you can copy the `.luarc-with-consts.json` file to your project instead, and name it `.luarc.json`.

> [!NOTE]
> This will slow your LSP down a lot as the constants are very large.

