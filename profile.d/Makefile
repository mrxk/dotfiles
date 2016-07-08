all:
	grep /dotfiles/profile.d/ ~/.bashrc 2>&1 > /dev/null; if [ "$$?" != "0" ]; then echo 'for i in ~/dotfiles/profile.d/*.sh ; do' >> ~/.bashrc; echo '    . "$$i"' >> ~/.bashrc; echo 'done' >> ~/.bashrc; fi;

