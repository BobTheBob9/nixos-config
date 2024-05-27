# use kitten to open a new window running neovim if neovim isn't open, if it is, then open the file in a new tab in neovim
# TODO: if (for whatever reason) we don't clean up a .pipe file (maybe bad restart) then this will break, bleh
if [ -e ~/.cache/nvim/server$(basename $(tty)).pipe ] 
then
	# using just nvim, rather than kitten @ launch here seems to spew some garbage into stdin for whatever reason
	kitten @ launch nvim --server ~/.cache/nvim/server$(basename $(tty)).pipe --remote-tab-silent $(realpath $1)
	kitten @ next_window # doesn't work :c
else
	kitten @ launch nvim --listen ~/.cache/nvim/server$(basename $(tty)).pipe $(realpath $1)
fi
