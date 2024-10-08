"--------------------------------------------------------------------------- 
" SNIPPETS
"--------------------------------------------------------------------------- 
let s:snips_dir = expand('~/.config/nvim/snippets')
nnoremap <leader>sco :-1read $HOME/.config/nvim/snippets/comp<CR>8jw<CR>
nnoremap <leader>sd :-1read $HOME/.config/nvim/snippets/describe<CR>10li
nnoremap <leader>si :-1read $HOME/.config/nvim/snippets/it<CR>11li
nnoremap <leader>dtrap :-1read $HOME/.config/nvim/snippets/trap<CR>o
nnoremap <leader>s1 :-1read $HOME/.config/nvim/snippets/1on1<CR>jA
nnoremap <leader>sdo :-1read $HOME/.config/nvim/snippets/do<CR>:pu=' -'<CR>:pu=strftime('%m/%d')<CR>kkJJhhi 
nnoremap <leader>sl :-1read $HOME/.config/nvim/snippets/line<CR>
nnoremap <leader>su :-1read $HOME/.config/nvim/snippets/uml<CR>
nnoremap <leader>slog :-1read $HOME/.config/nvim/snippets/con<CR>30li
nnoremap <leader>srow :-1read $HOME/.config/nvim/snippets/row<CR>
nnoremap <leader>sopt :-1read $HOME/.config/nvim/snippets/opt<CR>
