MiniDeps.add('MeanderingProgrammer/render-markdown.nvim')

require('render-markdown').setup({
    anti_conceal = { enabled = false },
    render_modes = { 'n', 'c', 't' },
})
