return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
    },
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    init = function()
      require("nvim-treesitter.configs").setup({})
    end,
  },
}
