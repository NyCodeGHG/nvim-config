return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      return require('alpha.themes.dashboard').config
    end,
    -- opts = {
    --   layout = {
    --     { type = 'padding', val = 2 },
    --     {
    --       type = 'text',
    --       val = {
    --         [[               ,]],
    --         [[             _/((]],
    --         [[    _.---. .'   `\]],
    --         [[  .'      `     ^ T=]],
    --         [[ /     \       .--']],
    --         [[|      /       )'-.]],
    --         [[; ,   <__..-(   '-.)]],
    --         [[ \ \-.__)    ``--._)]],
    --         [[  '.'-.__.-.]],
    --         [[    '-...-']],
    --         [[]],
    --         [[      Neovim ]],
    --       },
    --       opts = {
    --         position = 'center',
    --         hl = 'Type',
    --       },
    --     },
    --     {
    --       type = 'padding',
    --       val = 2,
    --     },
    --     {
    --       type = 'button',
    --       val = 'New File',
    --       on_press = function ()
    --         print("new")
    --       end,
    --       opts = {
    --         position = 'center',
    --         shortcut = 'n',
    --         cursor = 5,
    --         width = 50,
    --         align_shortcut = 'right',
    --         hl_shortcut = 'Keyword',
    --       }
    --     },
    --   },
  },
}
