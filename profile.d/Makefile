all:
	touch ~/.bashrc
	grep /dotfiles/profile.d/ ~/.bashrc 2>&1 > /dev/null; if [ "$$?" != "0" ]; then echo 'for i in ~/dotfiles/profile.d/*.sh ; do' >> ~/.bashrc; echo '    . "$$i"' >> ~/.bashrc; echo 'done' >> ~/.bashrc; fi;
	if [ ! -e ~/.bashrc_profile ]; then ln -s ~/.bashrc ~/.bashrc_profile; fi;
	if [ ! -e ~/.profile ]; then ln -s ~/.bashrc ~/.profile; fi;

