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

-- Terminal
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit terminal" })
vim.keymap.set("t", "<C-h>", "<c-\\><c-n><c-w>h", { desc = "Terminal left window navigation" })
vim.keymap.set("t", "<C-j>", "<c-\\><c-n><c-w>j", { desc = "Terminal down window navigation" })
vim.keymap.set("t", "<C-k>", "<c-\\><c-n><c-w>k", { desc = "Terminal up window navigation" })
vim.keymap.set("t", "<C-l>", "<c-\\><c-n><c-w>l", { desc = "Terminal right window navigation" })

vim.keymap.set("t", "<C-t>", "<cmd>:ToggleTerm<cr>", { desc = "Toggle Terminal" })
vim.keymap.set("n", "<leader>tt", "<cmd>:ToggleTerm<cr>", { desc = "Toggle Terminal" })
