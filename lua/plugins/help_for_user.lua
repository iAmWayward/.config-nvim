return {
  { "timwmillard/uuid.nvim" },
  {
    "alex-popov-tech/store.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim",
    },
    cmd = "Store",
    keys = {
      { "<leader>S", "<cmd>Store<cr>", desc = "Open Plugin Store" },
    },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    opts = {
      win = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Group labels shown in the which-key popup
      wk.add({
        { "<leader>t",   group = "Toggle" },
        { "<leader>n",   group = "NoNeckPain / Notes / Neogen" },
        { "<leader>nn",  group = "NoNeckPain" },
        { "<leader>ng",  desc  = "Generate docs (Neogen)" },
        { "<leader>p",   group = "Games" },
        { "<leader>f",   group = "Find (Telescope)" },
        { "<leader>fg",  group = "Git Finder" },
        { "<leader>g",   group = "Git" },
        { "<leader>gh",  group = "Git Hunks" },
        { "<leader>gt",  group = "Git Toggles" },
        { "<leader>x",   group = "Diagnostics/Trouble" },
        { "<leader>xt",  group = "Trouble types" },
        { "<leader>d",   group = "Documentation" },
        { "<leader>h",   group = "Harpoon" },
        { "<leader>u",   group = "UI/Hints" },
        { "<leader>c",   group = "Code" },
        { "<leader>r",   group = "Refactor" },
        { "<leader>w",   group = "Workspace" },
        { "z",           group = "Folds" },
      })

      -- Register all global keymaps
      require("config.keymaps").setup()
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lazy = false,
      enabled = false,
      restriction_mode = "hint",
    },
  },
  { "mong8se/actually.nvim" },
  { "tenxsoydev/tabs-vs-spaces.nvim", config = true },
  {
    "TrevorS/uuid-nvim",
    lazy = true,
    config = function()
      require("uuid").setup({ case = "upper" })
      vim.keymap.set("i", "<C-u>", require("uuid").insert_v4, { desc = "Insert UUID" })
    end,
  },
}
