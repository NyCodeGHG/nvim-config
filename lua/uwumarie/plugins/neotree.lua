return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    keys = {
      { '<leader>ft', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    },
    branch = 'v2.x',
    config = function()
      require('neo-tree').setup()
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
  },
}
