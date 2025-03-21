-- return {
--  {
--    "williamboman/mason.nvim",
--    config = function()
--      require("mason").setup()
--    end
--  },
--  {
--    "williamboman/mason-lspconfig.nvim",
--    config = function()
--      require("mason-lspconfig").setup({
--        ensure_installed = { "lua_ls", "ts_ls", "phpactor" }
--      })
--    end
--  },
--  {
--    "neovim/nvim-lspconfig",
--    config = function()
--      local capabilities = require('cmp_nvim_lsp').default_capabilities()
--      local lspconfig = require("lspconfig")
--      lspconfig.lua_ls.setup({
--        capabilities = capabilities
--      })
--      lspconfig.ts_ls.setup({
--        capabilities = capabilities
--      })
--
--      vim.keymap.set('n', 'GH', vim.lsp.buf.hover, {})
--      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
--      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
--    end
--  }
-- }
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = {
--     "williamboman/mason.nvim",
--     "williamboman/mason-lspconfig.nvim",
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     "hrsh7th/nvim-cmp",
--     "j-hui/fidget.nvim",
--     'L3MON4D3/LuaSnip',
--     'saadparwaiz1/cmp_luasnip',
--   },
--
--   config = function()
--     local cmp = require('cmp')
--     local cmp_lsp = require("cmp_nvim_lsp")
--     local capabilities = vim.tbl_deep_extend(
--       "force",
--       {},
--       vim.lsp.protocol.make_client_capabilities(),
--       cmp_lsp.default_capabilities())
--
--     require("fidget").setup({})
--     require("mason").setup()
--     require("mason-lspconfig").setup({
--       ensure_installed = {
--         "lua_ls"
--       },
--       handlers = {
--         function(server_name) -- default handler (optional)
--           require("lspconfig")[server_name].setup {
--             capabilities = capabilities
--           }
--         end,
--
--         ["lua_ls"] = function()
--           local lspconfig = require("lspconfig")
--           lspconfig.lua_ls.setup {
--             capabilities = capabilities,
--             settings = {
--               Lua = {
--                 diagnostics = {
--                   globals = { "vim", "it", "describe", "before_each", "after_each" },
--                 }
--               }
--             }
--           }
--         end,
--       }
--     })
--
--     local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
--
--     cmp.setup({
--       snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--           --  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--           require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--           --require('snippy').expand_snippet(args.body) -- For `snippy` users.
--           -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--         end,
--       },
--
--       mapping = cmp.mapping.preset.insert({
--         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         ["<C-Space>"] = cmp.mapping.complete(),
--       }),
--
--       sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' }, -- For luasnip users.
--       }, {
--         { name = 'buffer' },
--       }),
--
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--       },
--       completion = {
--         completeopt = 'menu,menuone,noinsert'
--       }
--     })
--
--     vim.diagnostic.config({
--       -- update_in_insert = true,
--       float = {
--         focusable = false,
--         style = "minimal",
--         border = "rounded",
--         source = "always",
--         header = "",
--         prefix = "",
--       },
--     })
--     vim.keymap.set('n', 'GH', vim.lsp.buf.hover, { noremap = true, silent = true })
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
--     vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
--     vim.api.nvim_buf_set_keymap(0, 'n', 'GH', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
--   end
-- }
-- return {
--   {
--     "williamboman/mason.nvim",
--     config = function()
--       require("mason").setup()
--     end
--   },
--   {
--     "williamboman/mason-lspconfig.nvim",
--     config = function()
--       require("mason-lspconfig").setup({
--         ensure_installed = { "lua_ls", "ts_ls", "phpactor" },
--         automatic_installation = true,
--       })
--     end
--   },
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       local capabilities = require('cmp_nvim_lsp').default_capabilities()
--       local lspconfig = require("lspconfig")
--
--       -- Setup LSP servers
--       lspconfig.lua_ls.setup({
--         capabilities = capabilities,
--         settings = {
--           Lua = {
--             diagnostics = {
--               globals = { 'vim' }, -- Recognize 'vim' global for Neovim
--             },
--           },
--         },
--       })
--       lspconfig.ts_ls.setup({
--         capabilities = capabilities,
--       })
--       lspconfig.phpactor.setup({
--         capabilities = capabilities,
--         filetypes = { "php" },
--       })
--
--       -- Custom hover function to include diagnostics
--       local function show_hover_with_diagnostics()
--         -- Get diagnostics for the current line
--         local line = vim.api.nvim_win_get_cursor(0)[1] - 1
--         local diagnostics = vim.diagnostic.get(0, { lnum = line })
--
--         -- If there are diagnostics, format them
--         local diag_message = ""
--         if #diagnostics > 0 then
--           diag_message = "Diagnostics:\n"
--           for i, diag in ipairs(diagnostics) do
--             diag_message = diag_message .. string.format("%d. %s\n", i, diag.message)
--           end
--         end
--
--         -- Call the default hover handler and append diagnostics
--         vim.lsp.buf.hover()
--         if diag_message ~= "" then
--           vim.api.nvim_echo({ { diag_message, "WarningMsg" } }, false, {})
--         end
--       end
--
--       -- Keybindings
--       vim.keymap.set('n', 'GH', show_hover_with_diagnostics, { desc = "Hover with diagnostics" })
--       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
--       vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
--     end
--   }
-- }
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    -- Setup completion capabilities
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Setup fidget for LSP progress
    require("fidget").setup({})

    -- Setup Mason and Mason-LSPconfig
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "phpactor" }, -- Add phpactor
      automatic_installation = true,
      handlers = {
        -- Default handler for unconfigured servers
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- Custom handler for lua_ls
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,
        -- Custom handler for ts_ls
        ["ts_ls"] = function()
          require("lspconfig").ts_ls.setup({
            capabilities = capabilities,
          })
        end,
        -- Custom handler for phpactor
        ["phpactor"] = function()
          require("lspconfig").phpactor.setup({
            capabilities = capabilities,
            filetypes = { "php" },
            init_options = {
              ["language_server.diagnostics_on_update"] = true,
              ["language_server.diagnostics_on_save"] = true,
            },
            on_attach = function(client, bufnr)
              print("phpactor attached to buffer " .. bufnr) -- Debug attachment
            end,
          })
        end,
      },
    })

    -- Setup nvim-cmp
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- Using LuaSnip
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
    })

    -- Diagnostics configuration
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Custom hover function with diagnostics (from your previous config)
    local function show_hover_with_diagnostics()
      local line = vim.api.nvim_win_get_cursor(0)[1] - 1
      local diagnostics = vim.diagnostic.get(0, { lnum = line })
      local diag_message = ""
      if #diagnostics > 0 then
        diag_message = "Diagnostics:\n"
        for i, diag in ipairs(diagnostics) do
          diag_message = diag_message .. string.format("%d. %s\n", i, diag.message)
        end
      end
      vim.lsp.buf.hover()
      if diag_message ~= "" then
        vim.api.nvim_echo({ { diag_message, "WarningMsg" } }, false, {})
      end
    end

    -- Keybindings
    vim.keymap.set("n", "GH", show_hover_with_diagnostics, { noremap = true, silent = true, desc = "Hover with diagnostics" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })
  end,
}
