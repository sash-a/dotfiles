return {
  {
    "akinsho/toggleterm.nvim",
    -- tag = '*',
    config = function()
      require("toggleterm").setup({ auto_scroll = false })
      -- toggle term
      vim.keymap.set('n', '<leader>tv', ':ToggleTerm size=80 direction=vertical <cr>', { desc = '[T]erminal [V]ertical' })
      vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float <cr>', { desc = '[T]erminal [f]oat' })
      vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=tab <cr>', { desc = '[T]erminal [T]ab' })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jj', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      -- lazygit
      -- local Terminal = require('toggleterm.terminal').Terminal
      -- local lazygit  = Terminal:new({
      -- 	cmd = "lazygit",
      -- 	dir = "git_dir",
      -- 	direction = "float",
      -- 	float_opts = {
      -- 		border = "double",
      -- 	},
      -- 	-- function to run on opening the terminal
      -- 	on_open = function(term)
      -- 		vim.cmd("startinsert!")
      -- 		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      -- 	end,
      -- 	-- function to run on closing the terminal
      -- 	on_close = function(term)
      -- 		vim.cmd("startinsert!")
      -- 	end,
      -- })
      --
      -- function _lazygit_toggle()
      -- 	lazygit:toggle()
      -- end

      -- vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>",
      -- 	{ noremap = true, silent = true, desc = '[L]azy [G]it' }
      -- )
      -- vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>",
      -- 	{ noremap = true, silent = true, desc = '[L]azy [G]it' }
      -- )
    end
  }
}
