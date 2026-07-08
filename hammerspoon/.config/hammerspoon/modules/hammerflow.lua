--
-- Hammerflow
--

local wm = spoon.WindowManager

hs.loadSpoon("Hammerflow")

spoon.Hammerflow.registerFunctions({
    moveWindowToWestScreen = function() wm:moveWindowToScreen("west") end,
    moveWindowToEastScreen = function() wm:moveWindowToScreen("east") end,
    toggleMaximizeWindow = function() wm:toggleMaximize() end,
    minimizeWindow = function() wm:minimizeWindow() end,
    fullscreenWindow = function() wm:fullscreenWindow() end,
})

spoon.Hammerflow.loadFirstValidTomlFile({
    "hammerflow.toml",
})

-- optionally respect auto_reload setting in the toml config.
if spoon.Hammerflow.auto_reload then
    hs.loadSpoon("ReloadConfiguration")
    -- set any paths for auto reload
    -- spoon.ReloadConfiguration.watch_paths = {hs.configDir, "~/path/to/my/configs/"}
    spoon.ReloadConfiguration:start()
end
