local command
if vim.fn.has("windows") == 1 then
  command = "lazygit"
else
  command = { "sh", "-icl", "lazygit" }
end

vim.keymap.set("n", "<leader>gg", function()
  local Util = require("lazyvim.util")
  Util.float_term(command, { cwd = Util.get_root() })
end, { desc = "Lazygit (root dir)" })

vim.keymap.set("n", "<leader>gG", function()
  local Util = require("lazyvim.util")
  Util.float_term(command)
end, { desc = "Lazygit (cwd)" })

vim.keymap.set("n", "<leader>fR", function()
  require("telescope.builtin").resume()
end, { desc = "Recent Telescope" })
