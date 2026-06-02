--
-- Hammerflow
--

local windows = require("modules.windows")

hs.loadSpoon("Hammerflow")

spoon.Hammerflow.registerFunctions({
    moveWindowToNextScreen = function() windows.moveWindowToScreen("next") end,
    moveWindowToPrevScreen = function() windows.moveWindowToScreen("prev") end,
    maximizeWindow = windows.maximizeWindow,
    restoreWindow = windows.restoreWindow,
    fullscreenWindow = windows.fullscreenWindow,
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
