" ###################################
"  plugins Setting
" ###################################

if !1 | finish | endif

if has('vim_starting')
	if &compatible
		set nocompatible
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
        let g:make = 'make'
endif
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
NeoBundle 'Shougo/vimfiler'
autocmd VimEnter * VimFiler -buffer-name=explorer -simple -split -winwidth=30 -toggle -no-quit
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

NeoBundle 'Shougo/vimshell'

highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=0

NeoBundle 'vim-scripts/yanktmp.vim'
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr> 
let g:yanktmp_file = $HOME.'/tmp/vimyanktmp'

NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_ruby_checkers = ['rubocop']

"NeoBundle 'vim-ruby/vim-ruby'
"NeoBundle 'janx/vim-rubytest'
"NeoBundle 'tpope/vim-rails'
NeoBundle 'gregsexton/gitv'

"NeoBundle 'soh335/vim-symfony'

"NeoBundle 'vim-scripts/DBGp-client'
NeoBundle 'vim-scripts/netrw.vim'
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_winsize = 80
NeoBundle 'jnurmine/Zenburn'

NeoBundle 'itchyny/lightline.vim'

NeoBundle 'editorconfig/editorconfig-vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

colorscheme zenburn 

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


filetype plugin indent on
syntax on

" ###################################
" default settings
" ###################################
" 構文ごとに色分け表示する
syntax on
"syntax onの場合のコメント文の色を変更する
highlight Comment ctermfg=LightCyan
"新しい行のインデントを現在行と同じにする
"set autoindent
" vim の独自拡張機能を使う[viとの互換性をとらない]
set nocompatible
"タブの代わりに空白文字を挿入する
"set expandtab
" 自動認識させる改行コードを指定する
set fileformats=unix,dos
" ウィンドウ枠にタイトルを表示する
set title
" 行番号を表示する
set number
" 検索時、大文字/小文字の区別無視
"set ignorecase
" 大文字小文字を区別して検索
set noic
" 検索強調
set hlsearch
"インクリメンタルサーチを行う
"set incsearch
" 括弧入力時に対応する括弧を強調する
set showmatch
" ウィンドウ幅で行を折り返す
set wrap
" バックスペース対応
set backspace=indent,eol,start
"ファイルの文字コード自動確認
:setl ff=unix
:set encoding=utf-8
:set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
:set fileformats=unix,dos,mac
:set fenc=utf-8
" ウィンドウ枠にタイトルを表示する
set display=uhex
" スクロール時の余白確保
set scrolloff=2
" コマンドラインの高さ
set cmdheight=1
" ステータスラインを常に表示する
set laststatus=2
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインに出力する内容のフォーマット
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[TYPE=%Y]\[ASCII=\%03.3b]\[HEX=\%02.2B]\[POS=%04l,%04v][LOW=%l/%L]
"ESC2回押しで、検索ハイライトを消去
:nnoremap <ESC><ESC> :nohlsearch<CR>
"256使用する
set t_Co=256
