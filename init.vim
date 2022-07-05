set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

let @/=""
set relativenumber
set number
set smartcase
set backspace=indent,eol,start
set hlsearch
set autoindent
set scrolloff=3
set cursorline
" set textwidth=120
" set colorcolumn=+3

" smartcase search
set ignorecase
set smartcase

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set autoread
au FocusGained,BufEnter * checktime
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

filetype plugin indent on
syntax on

au BufNewFile,BufRead *.ejs set filetype=html

call plug#begin()
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/vim-be-good'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'jiangmiao/auto-pairs'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" coc extensions
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}


Plug 'tpope/vim-commentary'

Plug 'sbdchd/neoformat'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-surround'

" telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'BurntSushi/ripgrep'
call plug#end()



let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank']
" gt will show the type of whatever you hover on
nnoremap <silent> gt :call CocAction('doHover')<CR>

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv



function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()


" go to definition, etc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" == AUTOCMD ================================
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
" == AUTOCMD END ================================



set termguicolors
if $NVIM_PLUGIN_INSTALLING == ""
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
require'nvim-tree'.setup()

EOF


" italics support
set t_ZH=^[[3m
set t_ZR=^[[23m
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let g:tokyonight_colors = {
      \ 'comment': '#899ddf',
      \ }

let g:tokyonight_style = "day"
colorscheme tokyonight
else
  echo "skipping install step"
endif
nnoremap <leader>sv :source $MYVIMRC<CR>
autocmd BufWritePre * :%s/\s\+$//e

nnoremap <CR><CR> :noh<return>

cabb W w
cabb Q q


" Best practice override this with a prettierrc every time.
let g:prettier#preset#config = get(g:,'prettier#preset#config', 'fb')
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap s o<Esc>k
nnoremap <C-d> "_d

nnoremap <C-g> <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
" mnemonic mark-file
nnoremap mf <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap m1 <cmd>lua require("harpoon.ui").nav_file(1)<cr>
nnoremap m2 <cmd>lua require("harpoon.ui").nav_file(2)<cr>
nnoremap m3 <cmd>lua require("harpoon.ui").nav_file(3)<cr>
nnoremap m4 <cmd>lua require("harpoon.ui").nav_file(4)<cr>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"


