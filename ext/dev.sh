# TODO: restrict source of remote stuff to current kitty window... somehow
# use kitten to open a new window running neovim if neovim isn't open, if it is, then open the file in a new tab in neovim
if [ -e ~/.cache/nvim/server$(basename $(tty)).pipe ] 
then
	# using just nvim, rather than kitten @ launch here seems to spew some garbage into stdin for whatever reason
	kitten @ launch nvim --server ~/.cache/nvim/server$(basename $(tty)).pipe --remote-tab-silent $(realpath $1)
else
	kitten @ launch nvim --listen ~/.cache/nvim/server$(basename $(tty)).pipe $(realpath $1)
fi
