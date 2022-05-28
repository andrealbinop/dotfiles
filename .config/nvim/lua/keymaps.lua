function r(modeorkey, keyorcmd, cmd, opts)
  mode = cmd and modeorkey or "n"
  key = cmd and keyorcmd or modeorkey
  cmd = cmd or keyorcmd
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  vim.api.nvim_set_keymap(mode, key, cmd, opts)
end

--Remap space as leader key
r("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- disable Ex mode, I always enter in it by mistake
r("Q", "<Nop>")

-- system clipboard integration
r("v", "<leader>y", '"+y')
r("v", "<leader>Y", '"+Y')

-- saving and quitting
r("<C-s>", ":w<CR>")
r("<C-q>", ":wq<CR>")
r("<C-S-Q>", ":quitall!<CR>")
-- telescope
r("<C-p>", ":Telescope find_files<CR>")
r("<C-h>", ":Telescope find_files hidden=true<CR>")
r("<C-S-P>", ":Telescope live_grep<CR>")
