-- Clone 'mini.deps' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.deps`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/nvim-mini/mini.deps', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.deps | helptags ALL')
    vim.cmd('echo "Installed `mini.deps`" | redraw')
end
-- Set up 'mini.deps'
require('mini.deps').setup({ path = { package = path_package } })

require('plugins.colourscheme')
require('plugins.lsp')
require('plugins.mini')
require('plugins.picker')
require('plugins.statusline')
require('plugins.treesitter')
require('plugins.whichkey')
require('plugins.git')
