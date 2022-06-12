return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'Mofiqul/dracula.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'khaveesh/vim-fish-syntax'
  use 'iberianpig/tig-explorer.vim'
end)

