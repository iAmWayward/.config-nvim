return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          typescript = { "template_string" },
          typescriptreact = { "template_string", "string", "comment" },
          javascriptreact = { "template_string", "string", "comment" },
        }
      })

      -- Add custom rules for JSX/TSX with more complete filetype handling
      npairs.add_rules({
        Rule("<", ">", { "typescriptreact" }),
        Rule("{", "}", { "typescriptreact" }),
        Rule("(", ")", { "typescriptreact" }),
        Rule("[", "]", { "typescriptreact" }),
        Rule("'", "'", { "typescriptreact" }),
        Rule('"', '"', { "typescriptreact" }),
        Rule("`", "`", { "typescriptreact" }),
      })

      -- Treesitter condition-based pairs
      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" }))
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if cmp_status_ok then
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  }
}
