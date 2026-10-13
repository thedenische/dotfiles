--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Route http(s) links to different browsers based on URL patterns.
--
-- Make Hammerspoon the default web browser (System Settings > Desktop & Dock >
-- Default web browser), then every link you click is handed to this Spoon,
-- which picks a browser using an ordered list of rules (first match wins) and
-- falls back to `defaultBrowser`.
--
-- Rules can also pass a profile (Chromium-based browsers) and extra
-- command-line flags to the target browser:
--
--   hs.loadSpoon("BrowserRouter")
--   spoon.BrowserRouter:configure({
--     defaultBrowser = "app.zen-browser.zen",
--     rules = {
--       {
--         browser = "com.google.Chrome",
--         profile = "Profile 1",
--         args    = { "--no-default-browser-check" },
--         hosts   = { "^https://work%.example%.com/" },
--       },
--     },
--   }):start()
--
-- Download: https://github.com/thedenische/BrowserRouter.spoon
---@class spoon.BrowserRouter
local M = {}
spoon.BrowserRouter = M

-- Dictionary of short browser names to bundle IDs. `browser` / `defaultBrowser`
-- accept either a name from this table (e.g. `"chrome"`) or a raw bundle ID.
-- Add your own entries as needed.
M.browsers = nil

-- Optional list of extra command-line flags for the default browser.
M.defaultArgs = nil

-- Bundle ID (or name from `browsers`) of the browser used when no rule
-- matches. Default: `"chromium"`.
M.defaultBrowser = nil

-- Optional profile directory (Chromium-based browsers) for the default browser.
M.defaultProfile = nil

-- Ordered list of routing rules; the first matching rule wins. Each rule is a
-- table with:
--  * browser - bundle ID or name from `browsers` of the target browser (required)
--  * hosts - list of Lua patterns matched against the full URL
--  * match - optional `function(url, scheme, host, params) -> boolean`, checked
--    in addition to `hosts`
--  * profile - optional profile directory name (Chromium-based browsers, e.g.
--    `"Default"`, `"Profile 1"`; see chrome://version > Profile Path)
--  * args - optional list of extra command-line flags (e.g.
--    `{ "--no-default-browser-check" }`)
M.rules = nil

-- List of `function(url, scheme, host, params) -> newUrl|nil` applied before
-- routing, e.g. to unwrap redirect links. Returning nil keeps the URL as is.
-- By default unwraps links opened from Microsoft Teams.
M.urlRewriters = nil

-- Set any of `defaultBrowser`, `defaultProfile`, `defaultArgs`, `rules`,
-- `urlRewriters`, `browsers` from a table (e.g. one loaded from a private
-- config file). `browsers` entries are merged into the built-in dictionary.
--
-- Parameters:
--  * config - table with any of the fields above; missing fields are left
--    unchanged
--
-- Returns:
--  * The BrowserRouter object
---@return spoon.BrowserRouter
function M:configure(config, ...) end

-- Open `url` in the browser with bundle ID `browser`.
--
-- Parameters:
--  * url - the URL to open
--  * browser - bundle ID or name from `browsers`
--  * profile - optional profile directory (Chromium-based browsers)
--  * args - optional list of extra command-line flags
--
-- Returns:
--  * The BrowserRouter object
--
-- Notes:
--  * Profile and flags are command-line arguments, so they only take effect
--    when the browser is launched; if it is already running the URL opens in
--    its current (last used) profile.
---@return spoon.BrowserRouter
function M:openURL(url, browser, profile, args, ...) end

-- Rewrite `url` via `urlRewriters`, find the first matching rule and open it
-- in that rule's browser (or the default browser).
--
-- Parameters:
--  * url - the full URL
--  * scheme, host, params - optional, as passed by `hs.urlevent.httpCallback`
--
-- Returns:
--  * The BrowserRouter object
---@return spoon.BrowserRouter
function M:route(url, scheme, host, params, ...) end

-- Start handling http(s) links (sets `hs.urlevent.httpCallback`).
--
-- Returns:
--  * The BrowserRouter object
---@return spoon.BrowserRouter
function M:start() end

-- Stop handling http(s) links (clears `hs.urlevent.httpCallback`).
--
-- Returns:
--  * The BrowserRouter object
---@return spoon.BrowserRouter
function M:stop() end

