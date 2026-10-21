-- Copilot status for the status line (see plugin/50_ui.lua), keyed by client id
Config.copilot_status = Config.copilot_status or {}

---@type vim.lsp.Config
return {
    handlers = {
        didChangeStatus = function(err, res, ctx)
            if err then
                return
            end
            Config.copilot_status[ctx.client_id] = res.kind ~= 'Normal' and 'error' or res.busy and 'pending' or 'ok'
            if res.kind == 'Error' then
                vim.notify('Copilot: ' .. (res.message or 'error') .. ', use :LspCopilotSignIn to sign in',
                    vim.log.levels.ERROR)
            end
        end,
    },
}
