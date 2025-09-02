local telescope = require('telescope')
local sorters = require('telescope.sorters')

require('denische.plugins.telescope.keymaps')

telescope.setup({
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            horizontal = {
                prompt_position = 'top'
            }
        },
        path_display = {
            filename_first = {
                reverse_directories = false,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        live_grep = {
            additional_args = function()
                return { '--hidden' }
            end
        },
        lsp_dynamic_workspace_symbols = {
            sorter = sorters.get_fzy_sorter(),
        }
    },
})
