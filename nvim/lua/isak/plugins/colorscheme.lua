return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "macchiato" })
      vim.cmd([[colorscheme catppuccin]])
      vim.cmd([[highlight Normal guibg=0000000 guifg=white]])
    end,
  },
}
