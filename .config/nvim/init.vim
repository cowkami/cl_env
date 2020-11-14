" my settings
set number

set expandtab
set smartindent
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set cursorline

" dein.vim settings
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  
  " Load setting up
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})

  " Load using
  call dein#load_toml('~/.config/nvim/lazy.toml', {'lazy': 1})

  call dein#add('vlime/vlime', {'rtp': 'vim/'})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
