# Set up the prompt

autoload -Uz promptinit
promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

alias mini='~/mini-moulinette/mini-moul.sh'

##########################
### Zap Plugin Manager ###
##########################

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/completions"
plug "zap-zsh/sudo"
plug "web-search"
plug "zap-zsh/fzf"
plug "zap-zsh/web-search"
plug "jeffreytse/zsh-vi-mode"

# Aliases
alias mycc="cc -Wall -Wextra -Werror"

alias norm="norminette -R CheckForbiddenSourceHeader"

alias ga="git add"
alias gst="git status"
alias gc="git commit -m"
alias gp="git push"
alias pl="git pull"
alias glgg="git log --graph --oneline --decorate"

alias v="nvim"

if ! systemctl status docker | grep running &> /dev/null; then
		echo "[Francinette] Starting Docker..."
		sleep 1
		exec "/bin/zsh"
fi
if ! docker image ls | grep francinette-image &> /dev/null; then
		echo "[Francinette] Loading the docker container"
		docker load < /home/adias-do/francinette-image/francinette.tar
		exec "/bin/zsh"
fi
if ! docker ps | grep "francinette-image" &> /dev/null; then
	if docker run -d -i -v /home:/home -v /goinfre:/goinfre -v /sgoinfre:/sgoinfre -v /home/adias-do/francinette-image/logs:/francinette/logs-t --name run-paco francinette-image /bin/bash 2>&1 | grep "already" &> /dev/null; then
		docker start run-paco
	fi
fi
alias francinette=/home/adias-do/francinette-image/run.sh

alias paco=/home/adias-do/francinette-image/run.sh

# Load Homebrew config script
source $HOME/.brewconfig.zsh

############################
### Load Starship Prompt ###
############################

if command -v starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    ZSH_THEME="refined"
fi
