vim.cmd([[
" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-v> "+p
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>
]])

vim.opt.guifont = { 'JetBrainsMono Nerd Font' }

if vim.loop.os_uname().sysname == 'Windows_NT' then
  vim.g.neovide_transparency = 1
else
  vim.g.neovide_transparency = 0.8
end
