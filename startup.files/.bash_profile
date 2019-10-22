Date
echo 'Hi There!!'

# Enable tab completion
source ~/.udacity-terminal-config/git-completion.bash

# Change command prompt
source ~/.udacity-terminal-config/git-prompt.sh

# colors!
darkGreen="\[\033[38;05;34m\]"
pink="\[\033[38;05;160m\]"
white="\[\033[38;05;15m\]"
red="\[\033[38;5;203m\]"
green="\[\033[38;05;38m\]"
blue="\[\033[0;34m\]"
reset="\[\033[0m\]"

export GIT_PS1_SHOWDIRTYSTATE=1

# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$darkGreen\u$pink\$(__git_ps1)$white \W
$ $reset"

# python path adding to path and making executable alias
export PATH="$PATH:/c/ProgramData/Anaconda3:/c/ProgramData/Anaconda3/Scripts"
alias python="winpty python.exe"

# minimual GNU for windows path addition - use for compiler setup installation
export PATH="$PATH:/c/MinGW/bin/"

# for making hard link in general and soft link in administartor mode
export MSYS="winsymlinks:nativestrict"

##### Auto-launching ssh-agent on Git for Windows 
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
ssh-add ~/.ssh/id_rsa
