return {
  {
    -- auto completion
    {
      'hrsh7th/nvim-cmp',
      version = false, -- last release is way too old
      event = 'InsertEnter',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
      },
      opts = function()
        vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local defaults = require 'cmp.config.default'()
        require('luasnip.loaders.from_vscode').lazy_load()

        local has_words_before = function()
          if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
            return false
          end
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
        end
        return {
          --completion = {
          -- completeopt = "menu,menuone,noinsert",
          --},
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<S-CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<C-CR>'] = function(fallback)
              cmp.abort()
              fallback()
            end,
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() and has_words_before() then
                cmp.select_next_item() 
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          sources = cmp.config.sources({
            { name = 'copilot', group_index = 2 },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
          }, {
            { name = 'buffer' },
          }),
          -- formatting = {
          -- },
          experimental = {
            ghost_text = {
              hl_group = 'CmpGhostText',
            },
          },
          sorting = defaults.sorting,
        }
      end,
      ---@param opts cmp.ConfigSchema
      config = function(_, opts)
        for _, source in ipairs(opts.sources) do
          source.group_index = source.group_index or 1
        end
        require('cmp').setup(opts)
      end,
    },
  },
  {
    {
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    },
  },
}
