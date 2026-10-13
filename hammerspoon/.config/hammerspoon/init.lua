hs.loadSpoon("EmmyLua")

hs.loadSpoon("WindowManager")

require("modules.hammerflow")

hs.loadSpoon("BrowserRouter"):loadConfig("browsers_config"):start()

hs.loadSpoon("ScreenAnnotate")
spoon.ScreenAnnotate:bindHotkeys() -- uses ScreenAnnotate.defaultHotkeys

