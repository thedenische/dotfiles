--
-- Browser routing: open URLs in different browsers based on host patterns
--
-- Make Hammerspoon the default browser in macOS Settings to use this.
-- Copy `browsers_config.example.lua` to `browsers_config.lua` to customize.
--

local DEFAULT_BROWSER = "app.zen-browser.zen"
local CONFIG_MODULE = "browsers_config"

local ok, config = pcall(require, CONFIG_MODULE)
if not ok then
    config = { defaultBrowser = DEFAULT_BROWSER, rules = {} }
end

local function openURL(url, browser, profile)
    if profile then
        -- Chromium-based browsers support --profile-directory.
        hs.task.new("/usr/bin/open", nil, {
            "-b", browser,
            "--args",
            "--profile-directory=" .. profile,
            url,
        }):start()
    else
        hs.urlevent.openURLWithBundle(url, browser)
    end
end

local rules = {}
for _, rule in ipairs(config.rules or {}) do
    table.insert(rules, {
        browser = rule.browser,
        profile = rule.profile,
        match = function(_, _, _, fullURL)
            for _, pattern in ipairs(rule.hosts or {}) do
                if string.match(fullURL, pattern) then
                    return true
                end
            end
            return false
        end,
    })
end

hs.urlevent.httpCallback = function(scheme, host, params, fullURL)
    -- link opened from MS Teams: unwrap original URL
    if host == "statics.teams.cdn.office.net" and params.url then
        fullURL = params.url
    end

    for _, rule in ipairs(rules) do
        if rule.match(scheme, host, params, fullURL) then
            openURL(fullURL, rule.browser, rule.profile)
            return
        end
    end
    openURL(fullURL, config.defaultBrowser or DEFAULT_BROWSER, config.defaultProfile)
end
