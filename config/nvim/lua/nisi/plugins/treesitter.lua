local config = require("nisi").config
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    commit = "42fc28ba918343ebfd5565147a42a26580579482",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/playground", commit = "ba48c6a62a280eefb7c85725b0915e021a1a0749" },
      { "nvim-treesitter/nvim-treesitter-textobjects", commit = "71385f191ec06ffc60e80e6b0c9a9d5daed4824c" },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        commit = "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f",
        init = function()
          vim.g.loaded_ts_context_commentstring = 1
        end,
        config = function()
          require("ts_context_commentstring").setup({
            enable_autocmd = true,
          })

          vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("user_ts_context_commentstring", { clear = true }),
            pattern = {
              "astro",
              "blade",
              "css",
              "html",
              "javascript",
              "javascriptreact",
              "php",
              "svelte",
              "typescript",
              "typescriptreact",
              "vue",
            },
            callback = function(args)
              require("ts_context_commentstring.internal").setup_buffer(args.buf)
            end,
          })
        end,
      },
    },
    init = function(plugin)
      if config.prefer_git then
        require("nvim-treesitter.install").prefer_git = true
      end
      require("lazy.core.loader").add_to_rtp(plugin)
      pcall(require, "nvim-treesitter.query_predicates")
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.treesitter.language.register("markdown", { "md", "mdx" })
    end,
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "blade",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
        "elixir",
        "eex",
        "heex",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "pug",
        "python",
        "regex",
        "ruby",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      highlight = { enable = true, use_languagetree = true },
      indent = { enable = true },
      rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to matching textobj
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        swap = {
          enable = false,
          swap_next = { ["<leader>a"] = "@parameter.inner" },
          swap_previous = { ["<leader>A"] = "@parameter.inner" },
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
  },
}
