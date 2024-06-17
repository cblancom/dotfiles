-- enable line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- width of a tab
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true

-- colorscheme
vim.cmd.colorscheme = "catppuccin-mocha"

vim.opt.clipboard = "unnamedplus"

-- spell schecker
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'es'
  end,
})
