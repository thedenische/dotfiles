--
-- Hammerflow
--

hs.loadSpoon("Hammerflow")

--
-- Window management: move window between monitors (with full screen support)
--
local function moveWindowToScreen(direction)
    local win = hs.window.focusedWindow()
    if not win then return end

    local screen = win:screen()
    local targetScreen = direction == "next" and screen:next() or screen:previous()
    if screen == targetScreen then return end

    local wasFullScreen = win:isFullScreen()

    if wasFullScreen then
        win:setFullScreen(false)
        hs.timer.doAfter(0.6, function()
            win:moveToScreen(targetScreen)
            hs.timer.doAfter(0.1, function()
                win:setFullScreen(true)
            end)
        end)
    else
        win:moveToScreen(targetScreen)
    end
end

--
-- Window management: maximize / restore
--
local savedFrames = {}

local function maximizeWindow()
    local win = hs.window.focusedWindow()
    if not win then return end

    local id = win:id()
    if not savedFrames[id] then
        savedFrames[id] = win:frame()
    end
    win:maximize()
end

local function restoreWindow()
    local win = hs.window.focusedWindow()
    if not win then return end

    if win:isFullScreen() then
        win:setFullScreen(false)
        return
    end

    local id = win:id()
    local frame = savedFrames[id]
    if frame then
        win:setFrame(frame)
        savedFrames[id] = nil
    end
end

local function fullscreenWindow()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:setFullScreen(true)
end

spoon.Hammerflow.registerFunctions({
    moveWindowToNextScreen = function() moveWindowToScreen("next") end,
    moveWindowToPrevScreen = function() moveWindowToScreen("prev") end,
    maximizeWindow = maximizeWindow,
    restoreWindow = restoreWindow,
    fullscreenWindow = fullscreenWindow,
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
