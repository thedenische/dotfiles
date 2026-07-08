--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Simple window management for Hammerspoon: move the focused window between monitors (with full-screen handling), maximize / restore it, or push it to native full screen.
--
-- `moveWindowToScreen` moves the focused window to the monitor physically adjacent in a given direction (`"east"` / `"west"` / `"north"` / `"south"`), following the display layout rather than an arbitrary ordering. If the window is in native full screen it is briefly taken out of full screen, moved, then put back -- so full-screen windows follow you across displays instead of refusing to move.
--
-- `maximizeWindow` remembers the window's current frame before maximizing, and `restoreWindow` puts it back (or drops out of full screen first if needed).
---@class spoon.WindowManager
local M = {}
spoon.WindowManager = M

-- Binds hotkeys for WindowManager.
--
-- Parameters:
--  * mapping - A table with any of the keys `moveWest`, `moveEast`, `moveNorth`, `moveSouth`, `toggleMaximize`, `maximize`, `restore`, `minimize`, `fullscreen`, each a `{ mods, key }` pair (e.g. `{ {"ctrl","cmd"}, "l" }`). Missing keys fall back to `WindowManager.defaultHotkeys` (which binds `toggleMaximize`, not the separate `maximize` / `restore`).
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:bindHotkeys(mapping, ...) end

-- Put the focused window into native macOS full screen.
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:fullscreenWindow() end

-- Maximize the focused window, remembering its current frame first so `restoreWindow` can put it back.
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:maximizeWindow() end

-- Minimize the focused window to the Dock. This is one-way: macOS gives a minimized window no focus, so there is no reliable target to un-minimize from a hotkey (click it in the Dock, or use the app's window menu, to bring back).
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:minimizeWindow() end

-- Move the focused window to the monitor physically adjacent in `direction`.
--
-- Parameters:
--  * direction - one of `"east"`, `"west"`, `"north"`, `"south"`. The target is the display in that direction relative to the window's current screen, so it follows the physical monitor layout (no wrap-around). If there is no monitor in that direction an alert is shown and nothing moves. If the window is in native full screen it is taken out of full screen, moved, and put back on the target display.
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:moveWindowToScreen(direction, ...) end

-- Restore the focused window: drop out of native full screen if it is in it, otherwise put it back to the frame saved by `maximizeWindow`.
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:restoreWindow() end

-- Toggle the focused window between maximized and its previous size: maximize it if it is not currently maximized (or full screen), otherwise restore it. Uses the frame saved by `maximizeWindow`, and exits native full screen if the window is in it.
--
-- Returns:
--  * The WindowManager object
---@return spoon.WindowManager
function M:toggleMaximize() end

