local Util = require("lazyvim.util")

local command
if vim.fn.has("win32") then
  command = "lazygit"
else
  command = { "sh", "-lic", "lazygit" }
end

vim.keymap.set("n", "<leader>gg", function()
  Util.float_term(command, { cwd = Util.get_root() })
end, { desc = "Lazygit (root dir)" })

vim.keymap.set("n", "<leader>gG", function()
  Util.float_term(command)
end, { desc = "Lazygit (cwd)" })
