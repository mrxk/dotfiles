all:
	if [ ! -e ~/.vimrc ]; then ln -s ~/dotfiles/vim/vimrc ~/.vimrc; fi
	if [ ! -e ~/.vim ]; then ln -s ~/dotfiles/vim/dotvim ~/.vim; fi
	vim +PlugInstall +qall
	vim +GoInstallBinaries +qall
	cd ~/dotfiles/vim/dotvim/plugged/YouCompleteMe && ./install.py --clang-completer --go-completer --java-completer

