alias ..='cd ..'
alias ...='cd ../..'

alias fcg='find . -type f -name "*cpp" | xargs grep '
alias fhg='find . -type f -name "*h" | xargs grep '
alias fpg='find . -type f -name "*py" | xargs grep '

alias h='history'
alias hg='history | grep '

alias envg='env | grep '

alias gdf='git diff'
alias gdt='git difftool'
alias gst='git status'
alias gba='git branch -a'
alias gco='git checkout'
alias gfe='git fetch'
alias gad='git add'
alias gada='git add --all'
alias glo='git log'
# Git Discard Changes https://stackoverflow.com/questions/52704/how-do-i-discard-unstaged-changes-in-git
alias gdc='git checkout -- .'

alias fn='find . -name '

alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge' # removes package and configuration
alias update='sudo apt-get update'

# if in future i want sth like - specify dir and cd there
#alias tsk='f(){ cd ~/Desktop/tasks/CT-$1;  unset -f f; }; f' # https://unix.stackexchange.com/questions/3773/how-to-pass-parameters-to-an-alias

#alias docpp='f(){ cd; mkdir ~/misc/misc_cpp/$1; cd ~/misc/misc_cpp/$1; cp ~/misc/misc_cpp/main.cpp ~/misc/misc_cpp/$1/; gvim main.cpp; }; f'
#alias undocpp='f(){ cd ~/misc; rm -rf misc_cpp/$1/*; rmdir misc_cpp/$1; }; f'

