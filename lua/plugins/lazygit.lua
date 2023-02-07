local command
if vim.fn.has("unix") then
  print("unix")
  command = { "sh", "-icl", "lazygit" }
else
  command = "lazygit"
end

vim.keymap.set("n", "<leader>gg", function()
  local Util = require("lazyvim.util")
  Util.float_term(command, { cwd = Util.get_root() })
end, { desc = "Lazygit (root dir)" })

vim.keymap.set("n", "<leader>gG", function()
  local Util = require("lazyvim.util")
  Util.float_term(command)
end, { desc = "Lazygit (cwd)" })
