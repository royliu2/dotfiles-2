local formatters = {
  javascript = { "biome", "biome-organize-imports", "prettier" },
  javascriptreact = { "biome", "biome-organize-imports", "prettier" },
  typescript = { "biome", "biome-organize-imports", "prettier" },
  typescriptreact = { "biome", "biome-organize-imports", "prettier" },
  markdown = { "prettier" },
  astro = { "prettier" },
  json = { "biome", "biome-organize-imports", "prettier" },
  jsonc = { "biome", "biome-organize-imports", "prettier" },
  html = { "prettier" },
  yaml = { "prettier" },
  css = { "stylelint", "prettier" },
  sh = { "shellcheck", "shfmt" },
  python = { "black", "isort" },
  go = { "gofmt" },
  lua = { "stylua" },
  ruby = { "rubocop" },
  php = { "pint" },
}

return {
  {
    "liuchengxu/vista.vim",
    lazy = true,
    cmd = "Vista",
    cond = not vim.g.vscode,
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    cond = not vim.g.vscode,
    dependencies = {
      -- Helpers to install LSPs and maintain them
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
      "saghen/blink.cmp",
    },
    config = function()
      require("nisi.plugins.lsp.config").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = false,
      },
      formatters_by_ft = formatters,
    },
  },

  {
    "folke/trouble.nvim",
    config = true,
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    config = true,
  },
  -- Moonfly theme
  {
    "bluz71/vim-moonfly-colors",
    priority = 1000,
    lazy = false,
    name = "moonfly",
  },

  -- Buffer bar
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      insert_at_start = true,
      -- …etc.
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
}
