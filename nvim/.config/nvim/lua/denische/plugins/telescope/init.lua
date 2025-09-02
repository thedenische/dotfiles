return {
    {
        'nvim-telescope/telescope.nvim',
        -- todo: switch to the branch '0.1.x' after `filename_first` is released
        -- branch = '0.1.x',
        branch = 'master',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('denische.plugins.telescope.config')
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            local telescope = require('telescope')

            telescope.setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown({})
                    }
                }
            }

            telescope.load_extension('ui-select')
        end
    }
}
