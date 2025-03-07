return {
  "folke/snacks.nvim",
  keys = {

    { "<leader>fg", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
  },

  opts = {
    picker = {
      ---@class snacks.picker.matcher.Config
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = true, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      win = {
        -- input window
        input = {
          keys = { ["<Tab>"] = { "list_down", mode = { "i", "n" } } },
        },
        list = {
          keys = { ["<Tab>"] = { "list_down", mode = { "i", "n" } } },
        },
      },
    },
  },
}
