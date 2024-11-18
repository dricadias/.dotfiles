# Set up the prompt

alias mycc="cc -Wall -Wextra -Werror"

alias norm="norminette -R CheckForbiddenSourceHeader"

autoload -Uz promptinit
promptinit
prompt adam1

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

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
alias mini='~/mini-moulinette/mini-moul.sh'


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
