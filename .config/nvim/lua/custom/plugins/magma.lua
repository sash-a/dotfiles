-- return {
--   {
--     {
--       "dccsillag/magma-nvim",
--       lazy = false,
--       version = "*",
--       build = "UpdateRemotePlugins",
--
--       keys = {
--         {
--           "<leader>ji",
--           "<cmd>MagmaInit<CR>",
--           desc =
--           "This command initializes a runtime for the current buffer."
--         },
--         { "<leader>jr",  "<cmd>MagmaEvaluateOperator<CR>", desc = "Evaluate the current operator." },
--         { "<leader>jrl", "<cmd>MagmaEvaluateLine<CR>",     desc = "Evaluate the current line." },
--         { "<leader>jrv", "<cmd>MagmaEvaluateVisual<CR>",   desc = "Evaluate the selected text." },
--         { "<leader>js",  "<cmd>MagmaShowOutput<CR>",       desc = "Show the output of the current buffer." },
--         { "<leader>jre", "<cmd>MagmaReevaluateCell<CR>",   desc = "Reevaluate the current cell." },
--         { "<leader>jd",  "<cmd>MagmaDelete<CR>",           desc = "Delete the current cell." },
--       },
--     }
--   }
-- }
-- magma
-- vim.g.magma_automatically_open_output = true
-- vim.g.magma_image_provider = "kitty"
return {
  {
    "dccsillag/magma-nvim",
    version = "*",
    build = ":UpdateRemotePlugins",
    lazy = false,
    keys = {
      {
        "<leader>jr",
        "<cmd>MagmaEvaluateOperator<CR>",
        desc = "Evaluate given operator",
        {
          noremap = true,
          expr = true,
          silent = true,
        },
      },
      {
        "<leader>ji",
        "<cmd>MagmaInit<CR>",
        desc =
        "Initializes a runtime for the current buffer."
      },
      {
        "<leader>jrl",
        "<cmd>MagmaEvaluateLine<CR>",
        desc = "Evaluate the current line.",
        {
          noremap = true,
          expr = true,
          silent = true,
        },
      },
      {
        "<leader>jrv",
        "<cmd>MagmaEvaluateVisual<CR>",
        desc = "Evaluate the selected text.",
        {
          noremap = true,
          expr = true,
          silent = true,
        },
      },
      {
        "<leader>js",
        "<cmd>MagmaShowOutput<CR>",
        desc = "Show the output of the current buffer.",
        {
          noremap = true,
          expr = true,
          silent = true,
        },
      },
      {
        "<leader>jre",
        "<cmd>MagmaReevaluateCell<CR>",
        desc = "Reevaluate the current cell.",
        {
          noremap = true,
          expr = true,
          silent = true,
        },
      },
      {
        "<leader>jd",
        "<cmd>MagmaDelete<CR>",
        desc = "Delete the current cell.",
        {
          noremap = true,
          expr = true,
          silent = true,
        },
      }
    },
  },
}
