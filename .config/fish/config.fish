## Official way to set Homebrew path according to the docs
set --global --export HOMEBREW_PREFIX "/opt/homebrew";
set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set --global --export HOMEBREW_REPOSITORY "/opt/homebrew";
fish_add_path --global --move --path "/opt/homebrew/bin" "/opt/homebrew/sbin";
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
if not contains "/opt/homebrew/share/info" $INFOPATH; set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH; end;

if status is-interactive
# Commands to run in interactive sessions can go here
  function fish_user_key_bindings
    fish_vi_key_bindings
  end

  starship init fish | source
  # TODO: learn fish, display random message, lol
  set fish_greeting "hello meks, do awesome"
end

# source /usr/local/opt/asdf/libexec/asdf.fish
set -gx STOW_DIR ~/.dotfiles
set -gx ERL_FLAGS "-kernel shell_history enabled"
set -Ux ERL_AFLAGS "-kernel shell_history enabled"
set -Ux EDITOR nvim
# source /opt/homebrew/opt/asdf/libexec/asdf.fish

# export global ("environment") variables
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache

direnv hook fish | source

# git aliases
alias g='git'

# docker aliases
# stops the container
alias dcs='docker-compose -f .docker/docker-compose.yml --env-file .docker/.env stop postgres'
# starts the container
alias dcu='docker-compose -f .docker/docker-compose.yml --env-file .docker/.env up -d postgres'
# lists current running containers
alias dps='docker ps'

# --add could also be -a
# abbr will expand the command out when you type it
# this will open the new meks_nvim instead of my base nvim that is tied to my dotfiles.
abbr --add meks_nvim NVIM_APPNAME=meks_nvim nvim

set -x PYO3_PYTHON python3

# Created by `pipx` on 2025-06-18 21:42:58
set PATH $PATH /Users/mmcclure/.local/bin
