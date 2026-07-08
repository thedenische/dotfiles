--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Screen annotation overlay for presenting: draw over the screen with the mouse, freeze it, zoom and pan -- all recorded like anything else on screen (unlike native macOS zoom).
--
-- The screen is "live" until it is frozen (a screenshot is taken): the first drag, ctrl+left-click, or the freeze hotkey all freeze it. While frozen you can draw, zoom, and pan on the still image; the apps underneath stay inert. Unfreezing drops the screenshot and goes back to live, without leaving the mode.
--
-- Zoom and drawing both live on the frozen screenshot canvas, so they are drawn into a normal Hammerspoon window. macOS Accessibility zoom is applied by the display compositor *after* screen capture and is invisible to OBS; this one is recorded like anything else on screen. Drawings are anchored to the content, so they zoom and pan along with the frozen screen underneath them.
--
-- ctrl+shift+left-click uses the native macOS zoom instead (live, but not recorded); it needs System Settings > Accessibility > Zoom > "Use keyboard shortcuts to zoom" enabled.
--
-- Mouse controls (while active):
--   left-drag         draw a red pen line   (freezes on first drag)
--   right-drag        draw a yellow marker  (freezes on first drag)
--   shift+drag        draw an arrow      (red on left, yellow on right)
--   cmd+drag          draw a rectangle   (red on left, yellow on right)
--   left/right-click  ripple highlight      (works on the live screen too)
--   ctrl+left-click   freeze + toggle zoom (max <-> normal) at the cursor
--   ctrl+shift+lclick native macOS zoom (live, not recorded by OBS)
--   ctrl+scroll       zoom in / out (clamped between normal and max) at cursor
--   move (zoomed)     pan by holding the cursor at a screen edge (after a beat)
--   ctrl+right-click  clear + unfreeze (or cancel native zoom), stay in the mode
--
-- Keyboard controls are configurable via `:bindHotkeys` (see `defaultHotkeys`):
--   toggle  turn annotation mode on / off          (default ctrl+alt+cmd+P)
--   freeze  toggle freeze (or cancel native zoom)   (default ctrl+F)
--   exit    exit annotation mode                    (default escape)
--
-- Visual and behavioural tunables live in `ScreenAnnotate.config`; override any field after `hs.loadSpoon("ScreenAnnotate")` and before `:start()`.
--
-- Download: https://github.com/thedenische/ScreenAnnotate.spoon
---@class spoon.ScreenAnnotate
local M = {}
spoon.ScreenAnnotate = M

-- Binds hotkeys for ScreenAnnotate.
--
-- Parameters:
--  * mapping - A table with any of the keys `toggle`, `freeze`, `exit`, each a `{ mods, key }` pair (e.g. `{ {"ctrl","alt","cmd"}, "w" }`). Missing keys fall back to `ScreenAnnotate.defaultHotkeys`. `toggle` is a global hotkey; `freeze` and `exit` are active only while annotation mode is on.
--
-- Returns:
--  * The ScreenAnnotate object
---@return spoon.ScreenAnnotate
function M:bindHotkeys(mapping, ...) end

-- Start annotation mode (same as triggering the `toggle` hotkey while off).
---@return spoon.ScreenAnnotate
function M:start() end

-- Stop annotation mode, clearing any freeze / drawings / zoom.
---@return spoon.ScreenAnnotate
function M:stop() end

-- Toggle annotation mode on / off.
---@return spoon.ScreenAnnotate
function M:toggle() end

