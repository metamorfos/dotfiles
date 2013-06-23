# because vim rocks
bindkey -v

# completion
autoload -Uz compinit && compinit

# colors and prompt
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# load up the configs inside ~/.zsh/*
for config_file ($HOME/.zsh/**/*.zsh) source $config_file
