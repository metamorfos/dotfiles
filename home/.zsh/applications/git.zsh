#!/bin/sh

# aliases with completion
alias g='git'
compdef g=git
alias gs='git status -sb'
compdef _git gst=git-status
alias gd='git diff'
compdef _git gd=git-diff
alias gp='git push'
compdef _git gp=git-push

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'

alias gco='git checkout'
compdef _git gco=git-checkout
alias gnd='git checkout -b'
compdef _git gnb=git-checkout
alias gdb='git branch -D'
compdef _git gdb=git-branch
alias go='git checkout'
compdef _git go=git-checkout
alias gpl='git pull --rebase'
compdef _git gpl=git-pull
alias gb='git branch'
compdef _git gb=git-branch
alias ga='git add'
compdef _git ga=git-add
