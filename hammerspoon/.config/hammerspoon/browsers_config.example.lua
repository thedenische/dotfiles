--
-- Browser routing configuration (example)
--
-- Copy this file to `browsers_config.lua` and customize.
-- The real config is gitignored so it can hold private host patterns.
--
-- Rules are evaluated in order; first match wins.
-- Patterns are Lua patterns (https://www.lua.org/manual/5.4/manual.html#6.4.1).
--
-- Common browser bundle IDs:
--   Zen:         app.zen-browser.zen
--   Firefox:     org.mozilla.firefox
--   Chrome:      com.google.Chrome
--   Chromium:    org.chromium.Chromium
--   Safari:      com.apple.Safari
--   Arc:         company.thebrowser.Browser
--   Brave:       com.brave.Browser
--   Edge:        com.microsoft.edgemac
--   Vivaldi:     com.vivaldi.Vivaldi
--   Opera:       com.operasoftware.Opera
--
-- Optional `profile` field works for Chromium-based browsers (Chrome, Edge,
-- Brave, Vivaldi, Chromium). Use the profile's directory name, e.g. "Default",
-- "Profile 1". Find it in chrome://version under "Profile Path".
--

return {
    defaultBrowser = "app.zen-browser.zen",

    rules = {
        {
            browser = "app.zen-browser.zen",
            hosts = {
                -- "https://.*%.example%.com/.*",
            },
        },
        -- Example with profile:
        -- {
        --     browser = "com.google.Chrome",
        --     profile = "Profile 1",
        --     hosts = { "https://work%.example%.com/.*" },
        -- },
    },
}
