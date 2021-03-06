# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

test -s ~/.alias && . ~/.alias || true

yellow=$(tput setaf 226) 
cyan=$(tput setaf 14) 
red=$(tput setaf 1) 
white=$(tput setaf 231) 
light_purple=$(tput setaf 13)

HISTTIMEFORMAT=`echo -e ${light_purple}%F %T $MY_BASH_NOCOLOR `

alias cp='cp -rv'
alias ls='ls --color=auto -ACF'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../..'
alias c='clear'
alias h='history'
alias tree='tree --dirsfirst -F'
alias mkdir='mkdir -p -v'

alias pym='python3 manage.py'
alias mkvenv='python3 -m venv venv'
alias startvenv='source venv/bin/activate && which python3'
alias stopvenv='deactivate venv'

alias gst='git st'
alias gco='git commit'
alias gch='git checkout'

alias ros='singularity run --nv ros-container.sif'
alias rosexam='singularity run --nv ros-container_1.sif'

if [[ "$(cat /etc/os-release)" == *"Ubuntu 18.04"* ]] ; then
    source /opt/ros/melodic/setup.bash
    source ~/catkin_ws/devel/setup.bash
    
    export TURTLEBOT3_MODEL="waffle"
    
    export ROS_MASTER_URI=http://localhost:11311
    export ROS_HOSTNAME=localhost
fi    

# Show branch when in a git repository
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Automatically execute ls when changing directory
cd() {
    builtin cd "$@" && ls
}

# Extract any type of compressed file
extract() {
    if [ -z ${1} ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: extract <archive> [directory]"
        echo "Example: extract presentation.zip."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.xz, tar, bz2, gz, tbz2,"
        echo "tbz, tgz, lzo, rar, zip, 7z, xz, txz, lzma and tlz"
    else
        case "$1" in
            *.tar.bz2|*.tbz2|*.tbz)         tar xvjf "$1" ;;
            *.tgz)                          tar zxvf "$1" ;;
            *.tar.gz)                       tar xvzf "$1" ;;
            *.tar.xz)                       tar xvJf "$1" ;;
            *.tar)                          tar xvf "$1" ;;
            *.rar)                          7z x "$1" ;;
            *.zip)                          unzip "$1" ;;
            *.7z)                           7z x "$1" ;;
            *.lzo)                          lzop -d  "$1" ;;
            *.gz)                           gunzip "$1" ;;
            *.bz2)                          bunzip2 "$1" ;;
            *.Z)                            uncompress "$1" ;;
            *.xz|*.txz|*.lzma|*.tlz)        xz -d "$1" ;;
            *) echo "Sorry, '$1' could not be decompressed." ;;
        esac
    fi
}

# List largest files in working directory
largestfiles() {
    du -h -x -s -- * | sort -r -h | head -20;
}

# Search through your history for previous run commands
hg() {
    history | grep "$1";
}

# Create an initialise a skeleton git repository
 gitInit() {
    if [ -z "$1" ]; then
        printf "%s\n" "Please provide a directory name.";
    else
        mkdir "$1";
        builtin cd "$1";
        pwd;
        git init;
        touch README.md .gitignore;
        echo "# $(basename $PWD)" >> README.md
    fi
}

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

export PS1="\[$yellow\]\u@\h \[$cyan\]\w \[$red\]\$(parse_git_branch)\[$white\]$ "
