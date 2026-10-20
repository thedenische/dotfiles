return {
    { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'x' }, desc = '[A]I [C]hat toggle' },
    { '<leader>aa', '<cmd>CodeCompanionActions<cr>',     mode = { 'n', 'x' }, desc = '[A]I [A]ctions' },
    { '<leader>ai', ':CodeCompanion ',                   mode = { 'n', 'x' }, desc = '[A]I [I]nline prompt' },
    { '<leader>as', '<cmd>CodeCompanionChat Add<cr>',    mode = 'x',          desc = '[A]I [S]end selection to chat' },
}
