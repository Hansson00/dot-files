return
{
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
    config = function()
      local lspconfig = require('lspconfig')

      -- Get keybinds for LSP
      local lsp_settings = require('isak.lsp.attach')

      lspconfig.clangd.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--header-insertion-decorators=false"
        }
      })

      lspconfig["lua_ls"].setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          }
        }
      })

      -- Zig
      lspconfig.zls.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
        cmd = { "zls" },
        filetypes = { "zig", "zir" },
        root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
        single_file_support = true,
      })


      lspconfig.cmake.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = lspconfig.util.root_pattern(".git"),
        single_file_support = true,
      })

      -- "languageserver": {
      --   "cmake": {
      --     "command": "cmake-language-server",
      --     "filetypes": ["cmake"],
      --     "rootPatterns": [
      --       "build/"
      --     ],
      --     "initializationOptions": {
      --       "buildDirectory": "build"
      --     }
      --   }
      -- }

      -- lspconfig.basedpyright.setup({
      --   settings = {
      --     basedpyright = {
      --       -- Using Ruff's import organizer
      --       disableOrganizeImports = true,
      --       analysis = {
      --         -- Ignore all files for analysis to exclusively use Ruff for linting
      --         ignore = { '*' },
      --       },
      --     },
      --   },
      --   capabilities = lsp_settings.capabilities,
      --   on_attach = lsp_settings.on_attach
      -- })

      -- lspconfig.ruff.setup({
      --   capabilities = lsp_settings.capabilities,
      --   on_attach = lsp_settings.on_attach
      -- })


      -- Diagnostics icons
      for name, icon in pairs(require("isak.util.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end
  },


  -- {
  --   'williamboman/mason.nvim',
  --   cmd = "Mason",
  --   dependencies = {
  --     "williamboman/mason-lspconfig.nvim",
  --     config = function()
  --       require("mason").setup()
  --       require("mason-lspconfig").setup {
  --         ensure_installed = {
  --           "lua_ls",
  --           "basedpyright",
  --         } }
  --     end
  --   },
  -- },
  --

  -- {
  --   "folke/lazydev.nvim",
  --   ft = "lua", -- only load on lua files
  --   opts = {},
  -- },

  {
    "p00f/clangd_extensions.nvim",
    ft = {
      "c",
      "cpp",
    },
    config = function()
      local group = vim.api.nvim_create_augroup("clangd_extensions", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("Filetype", {
        group = group,
        desc = "Setup clangd_extension scores for cmp",
        pattern = "c,cpp",
        callback = function()
          local cmp = require "cmp"
          cmp.setup.buffer {
            sorting = {
              comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                require "clangd_extensions.cmp_scores",
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
              },
            },
          }
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        desc = "Clangd specific keymaps",
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == "clangd" then
            require("clangd_extensions").setup()
            vim.keymap.set(
              "n",
              "<leader>ss",
              "<cmd>ClangdSwitchSourceHeader<CR>",
              { buffer = bufnr, desc = "Switch between source and header" })
          end
        end,
      })
    end,
  },

  vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- could also use ">>", "→", "⮞", etc.
      spacing = 2,
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.INFO]  = "",
        [vim.diagnostic.severity.HINT]  = "",
      }
    },

    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
}
