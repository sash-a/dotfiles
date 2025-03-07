return {
  "neovim/nvim-lspconfig",
  ---@type lspconfig.options
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              -- reportUnknownParameterType = false,
              -- reportUnknownArgumentType = false,
              -- reportUnknownLambdaType = false,
              -- reportUnknownVariableType = false,
              -- reportUnknownMemberType = false,
              -- reportAny = false,
              -- reportMissingTypeArgument = false,
              -- deprecateTypingAliases = false,
            },
          },
        },
      },
    },
  },
}
