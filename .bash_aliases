alias cp='rsync -ah --info=progress2'
alias ls='ls --color=auto -ACF'
alias lt='ls --human-readable --size -1 -S --classify'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../..'
alias clr='clear'
alias hist='history'
alias tree='tree --dirsfirst -F'
alias mkdir='mkdir -p -v'
alias mnt='mount | grep -E ^/dev | column -t'

alias pym='python3 manage.py'
alias mkvenv='python3 -m venv venv'
alias startvenv='source venv/bin/activate && which python3'
alias stopvenv='deactivate venv'

alias ros='singularity run --nv ros-container.sif'
alias rosexam='singularity run --nv ros-container_1.sif'