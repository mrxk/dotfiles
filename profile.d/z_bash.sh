# .bashrc

export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_111
export GRAILS_HOME=/usr/lib/grails-2.2.0
export PATH=$PATH:/usr/lib/grails-2.2.0/bin
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/Go/work

. ~/.bash_aliases

export PROMPT_COMMAND='export PS1="[\u@$\h:\w]$ "'
