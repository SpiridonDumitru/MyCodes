return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim", -- diff view integration
    "nvim-telescope/telescope.nvim", -- optional, for commit/branch pickers
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit Status" },
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
}
