let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
nnoremap <silent> <C-n> :Dirvish%<CR>
