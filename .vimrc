" ===========================================
" ===========================================
" Utilities
" -------------------------------------------
"set nowrap
set wildmenu
" no backup files
set nobackup
" only in case you dont want a backup file while editing
" set nowritebackup
" no swap files
set noswapfile
set autochdir


" ===========================================
" ===========================================
" Compiling File 
" -------------------------------------------
" set binary " removes eof
" set encoding=utf-8
" Remove trailing whitespace upon save
"function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    "let _s=@/
    "let l = line(".")
    "let c = col(".")
    " Do the business:
    "%s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    "let @/=_s
    "call cursor(l, c)
"endfunction
"autocmd BufWritePre *.rb,*.rake,*.coffee,*.html,*.styl :call <SID>StripTrailingWhitespaces()

" ===========================================
" Appearance and Highlighting
" -------------------------------------------
" needed for syntax highlighting
syntax on
" filetype plugin indent on
" stop highlighting past column 300 on very long lines (keeps redraws fast and
" avoids "redrawtime exceeded" disabling syntax on files with long lines)
set synmaxcol=300
set nu " set number guide on left
let g:indentLine_color_term = 239
" let g:indentLine_char = '┆'
" vim supports js, just do this to use js syntax highlighting for json
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.styl set ft=css
autocmd BufNewFile,BufRead *.em set ft=emblem
autocmd BufNewFile,BufRead *.slim set ft=emblem
autocmd BufNewFile,BufRead *.hbs set ft=html
autocmd BufNewFile,BufRead *.volt set ft=html
autocmd BufNewFile,BufRead *.twig set ft=html


" ===========================================
" ===========================================
" Tabline
" -------------------------------------------
" always show the tab bar, even with a single tab
set showtabline=2

" custom tabline: <num> <filename> [+ if modified], active tab highlighted
function! MyTabLine() abort
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let bufnr = tabpagebuflist(tab)[winnr - 1]
    let name = bufname(bufnr)
    " highlight group for the active vs inactive tab
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    " mark this region so mouse clicks switch to the tab
    let s .= '%' . tab . 'T'
    let s .= ' ' . tab . ' '
    let s .= (name !=# '' ? fnamemodify(name, ':t') : '[No Name]')
    let s .= (getbufvar(bufnr, '&modified') ? ' + ' : ' ')
  endfor
  " fill the remainder and close the last tab region
  let s .= '%#TabLineFill#%T'
  return s
endfunction
set tabline=%!MyTabLine()

" force visible tab colors regardless of colorscheme
hi TabLineSel  cterm=bold ctermfg=232 ctermbg=250
hi TabLine     cterm=none ctermfg=250 ctermbg=236
hi TabLineFill cterm=none ctermbg=236

" tab management: open, close, next/prev
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-w><C-t> :tabclose<CR>
" gt / gT still switch tabs by default


" ===========================================
" ===========================================
" Smoother Navigation on Vim
" -------------------------------------------
" easier split navigation, instead of ctrl-w, just use ctrl-hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" more natural split opening
set splitbelow
set splitright
" easy window resize
nnoremap <S-h> <C-w>< -15 
nnoremap <S-j> <C-W>- -15
nnoremap <S-k> <C-W>+ +15
nnoremap <S-l> <C-w>> +15


" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
"let g:netrw_browse_split = 4
let g:netrw_liststyle=3 " enable file navigation
"let g:netrw_winsize = 15 " set exact width for file navigation
"let g:netrw_altv=1 " open files to the right
"let g:netrw_preview=1 " open previews vertically


" ===========================================
" ===========================================
" Code Methods, Vars finder - TagBar
" -------------------------------------------
" https://github.com/majutsushi/tagbar
"nmap <F8> :TagbarToggle<CR>
" easy prev tab nav instead of g Ctrl 
"map fr gT T


" ===========================================
" ===========================================
" Indentation
" -------------------------------------------
" set tab width to 2
set tabstop=2
set shiftwidth=2
set expandtab
" enable auto indentation
set smartindent
set smarttab


" ===========================================
" ===========================================
" Syntastic Syntax Checker
" -------------------------------------------


" ===========================================
" ===========================================
" Enable Plugin
" -------------------------------------------
" execute pathogen#infect()
