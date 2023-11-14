return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  opts = {
    name = { "venv", "env" },
    anaconda_base_path =  "/home/sash/miniconda3" ,
    anaconda_envs_path =  "/home/sash/miniconda3/envs" ,
  },
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>cv", "<cmd>VenvSelect<cr>" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    -- { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
