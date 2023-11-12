return {
  'mfussenegger/nvim-lint',
  -- event = 'LazyFile',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      fish = { 'fish' },
      python = { 'flake8' },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      callback = function()
        local lint_status, lint = pcall(require, 'lint')
        if lint_status then
          lint.try_lint()
        end
      end,
    })
  end,
}
