-- null-ls
return {
  'jose-elias-alvarez/null-ls.nvim',
  requires = { "nvim-lua/plenary.nvim" },
  config = function()

  local null_ls = require("null-ls")
null_ls.setup({
sources = {
null_ls.builtins.formatting.black,
null_ls.builtins.formatting.isort,
null_ls.builtins.diagnostics.flake8,
null_ls.builtins.diagnostics.mypy,
},
})
  end
}
