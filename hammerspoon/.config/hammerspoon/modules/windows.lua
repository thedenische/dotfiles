--
-- Window management
--

local M = {}

--
-- Move window between monitors (with full screen support)
--
function M.moveWindowToScreen(direction)
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
-- Maximize / restore
--
local savedFrames = {}

function M.maximizeWindow()
    local win = hs.window.focusedWindow()
    if not win then return end

    local id = win:id()
    if not savedFrames[id] then
        savedFrames[id] = win:frame()
    end
    win:maximize()
end

function M.restoreWindow()
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

function M.fullscreenWindow()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:setFullScreen(true)
end

return M
