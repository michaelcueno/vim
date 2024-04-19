# To install

```
git clone git@github.com:michaelcueno/vim.git
mkdir .config/nvim
mv vim .config/nvim
```

``` 
git submodule update --init --recursive
```
then 
```
cp .vimrc ~/
```
or set alias: 
```
alias vim='vim -u ~/.vim/.vimrc'
``` 

# To add submodules 

```
git submodule add <remote_url> <destination_folder>
```
# TODO 
[ ] Add treesitter
