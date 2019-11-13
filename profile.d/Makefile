all:
	touch ~/.bashrc
	grep .bash_aliases ~/.bashrc 2>&1 > /dev/null; if [ "$$?" != "0" ]; then echo '. .bash_aliases' >> ~/.bashrc; fi;
	if [ ! -e ~/.bash_aliases ]; then ln -s ~/dotfiles/profile.d/bash_aliases ~/.bash_aliases; fi;
	if [ "${OSTYPE}" = "cygwin" ]; then grep /dotfiles/profile.d/ ~/.bashrc 2>&1 > /dev/null; if [ "$$?" != "0" ]; then echo 'for i in ~/dotfiles/profile.d/*.sh ; do' >> ~/.bashrc; echo '    . "$$i"' >> ~/.bashrc; echo 'done' >> ~/.bashrc; fi; fi;
	if [ "${OSTYPE}" = "cygwin" ]; then if [ ! -e ~/.bashrc_profile ]; then ln -s ~/.bashrc ~/.bashrc_profile; fi; fi;
	if [ "${OSTYPE}" = "cygwin" ]; then if [ ! -e ~/.profile ]; then ln -s ~/.bashrc ~/.profile; fi; fi;

