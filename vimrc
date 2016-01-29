" some gems taken from https://bitbucket.org/sjl/dotfiles

set nocompatible
syntax on

filetype off
call pathogen#infect()
filetype plugin indent on

set modelines=0
set encoding=utf-8
set autoindent
set nosmartindent
set history=10000
set number
set background=dark
set hidden
set backspace=indent,eol,start
set textwidth=0

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

nmap , \

" search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
nnoremap <leader>a :Ag<space>
nnoremap <leader>s :vsplit<cr>

set cursorline
set wrap
set noswapfile
set bs=2

if &t_Co == 256
  "colorscheme lucius
  let base16colorspace=256
  colorscheme base16-flat
  set t_ut=
endif

" highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

" highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

" set quickfix window to appear after grep invocation
autocmd QuickFixCmdPost *grep* cwindow

set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1

map <silent> <LocalLeader>t :CommandT<CR>
map <silent> <LocalLeader>cf :CommandTFlush<CR>
map <silent> <LocalLeader>cb :CommandTBuffer<CR>
map <silent> <LocalLeader>cj :CommandTJump<CR>
map <silent> <LocalLeader>ct :CommandTTag<CR>
let g:CommandTAcceptSelectionSplitMap=['<C-s>']
let g:CommandTAcceptSelectionVSplitMap=['<C-v>']
let g:CommandTCancelMap=['<Esc>', '<C-c>']
let g:CommandTMaxHeight=10

imap <C-L> <SPACE>=><SPACE>

" copy and paste to Mac OS X clipboard
noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>
vnoremap <leader>y "*ygv

" window width
set winwidth=90
set winminwidth=15

" no arrow keys in normal and insert modes
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" keep the cursor in place while joining lines
nnoremap J mzJ`z

" split line
" the normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" disable help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" convert dos format to unix format
noremap <leader>ff :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>:w<CR>

" HTML tag folding
nnoremap <leader>ft Vatzf

" CSS properties sorting
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

let vimclojure#HighlightBuiltins=0
let vimclojure#ParenRainbow=1

command! ScratchToggle call ScratchToggle()

function! ScratchToggle()
    if exists("w:is_scratch_window")
        unlet w:is_scratch_window
        exec "q"
    else
        exec "normal! :Sscratch\<cr>\<C-W>L"
        let w:is_scratch_window = 1
    endif
endfunction

nnoremap <silent> <leader><tab> :ScratchToggle<cr>

set tabstop=2 shiftwidth=2 backspace=2 expandtab
set autoindent nowrap
nnoremap <leader><leader> <c-^>

" format JSON
map <Leader>j !python -m json.tool<CR>

set wildignore+=*/target/*
set wildignore+=bower_components,node_modules

autocmd VimEnter * RainbowParentheses

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

" By default, colors will be picked from the current color scheme
" " To override this behavior, define g:rainbow#colors as follows
" " (The colors in the example were taken from VimClojure)
 let g:rainbow#colors = {
 \   'dark': [
 \     ['yellow',  'orange1'     ],
 \     ['green',   'yellow1'     ],
 \     ['cyan',    'greenyellow' ],
 \     ['magenta', 'green1'      ],
 \     ['red',     'springgreen1'],
 \     ['yellow',  'cyan1'       ],
 \     ['green',   'slateblue1'  ],
 \     ['cyan',    'magenta1'    ],
 \     ['magenta', 'purple1'     ]
 \   ],
 \   'light': [
 \     ['darkyellow',  'orangered3'    ],
 \     ['darkgreen',   'orange2'       ],
 \     ['blue',        'yellow3'       ],
 \     ['darkmagenta', 'olivedrab4'    ],
 \     ['red',         'green4'        ],
 \     ['darkyellow',  'paleturquoise3'],
 \     ['darkgreen',   'deepskyblue4'  ],
 \     ['blue',        'darkslateblue' ],
 \     ['darkmagenta', 'darkviolet'    ]
 \   ]
 \ }

 let NERDTreeIgnore=['\.DS_Store$', '\.vim$']

 autocmd BufRead,BufWritePre *.java :UnusedImports

 vnoremap <leader>su :sort ui<CR>

 let g:indentLine_color_term = 239
 let g:indentLine_color_gui = '#09AA08'
 let g:indentLine_char = '│'

 let g:spotify_country_code = 'US'
 nnoremap <leader>m :Spotify<space>

" vim-rspec config
 let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
 let g:rspec_runner = "os_x_iterm"
 map <Leader>at :call RunCurrentSpecFile()<CR>
 map <Leader>rt :call RunNearestSpec()<CR>
