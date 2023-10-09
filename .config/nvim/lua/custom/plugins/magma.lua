return {
  {
    "dccsillag/magma-nvim",
    version = "*",
    build = ":UpdateRemotePlugins",
    lazy = false,
    keys = {
      {
        "<leader>ni",
        "<cmd>MagmaInit python3<CR>",
        desc =
        "[N]otebook [I]nit",
        {
          noremap = true,
          silent = true,
        },
      },
      {
        "<leader>nrl",
        "<cmd>MagmaEvaluateLine<CR>",
        desc = "[N]otebook [R]un [L]ine",
        {
          noremap = true,
          silent = true,
        },
      },
      {
        "<leader>nrv",
        "<cmd>MagmaEvaluateVisual<CR>",
        mode = "v",
        desc = "[N]otebook [R]un [V]isual",
        {
          noremap = true,
          silent = true,
        },
      },
      {
        "<leader>ns",
        "<cmd>MagmaShowOutput<CR>",
        desc = "[N]otebook [S]how output",
        {
          noremap = true,
          silent = true,
        },
      },
      {
        "<leader>nrr",
        "<cmd>MagmaReevaluateCell<CR>",
        desc = "[N]otebook [R]e[r]un cell",
        {
          noremap = true,
          silent = true,
        },
      },
      {
        "<leader>nd",
        "<cmd>MagmaDelete<CR>",
        desc = "[N]otebook [D]elete cell",
        {
          noremap = true,
          silent = true,
        },
      }
    },
  },
}
