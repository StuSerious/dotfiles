###> XDG
#> ENV variables
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
#> home cleanup
export CARGO_HOME="$XDG_DATA_HOME"/cargo                # .cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv             # .nv
export HISTFILE="$XDG_STATE_HOME"/zsh/history           # .zsh_history
export GOPATH="$XDG_DATA_HOME"/go                       # go/
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"  # .wget_hsts

###> P10K instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###> Zinit
#> source and plugins directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
#> get Zinit in absent
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
#> load zinit
source "${ZINIT_HOME}/zinit.zsh"

#> add P10K
zinit ice depth=1; zinit light romkatv/powerlevel10k
#> ZSH plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

#> ZSH snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages

###> completions
autoload -Uz compinit && compinit
#> replay compdefs
zinit cdreplay -q

###> load P10K
[[ ! -f ${ZDOTDIR:-~}/.p10k.zsh ]] || source ${ZDOTDIR:-~}/.p10k.zsh 

###> ZSH options
#> keybinds
bindkey -e                            # enable emacs mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
#> history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPEND_HISTORY         # append to $HISTFILE...
setopt INC_APPEND_HISTORY     # ...and append to $HISTFILE incrementally
setopt EXTENDED_HISTORY       # save timestamp and duration
setopt HIST_EXPIRE_DUPS_FIRST # delete dups first when overflowing
setopt HIST_FIND_NO_DUPS      # don't display duplicates
setopt HIST_IGNORE_DUPS       # don't append if just sent
setopt HIST_IGNORE_ALL_DUPS   # reset dups to last entry
setopt HIST_IGNORE_SPACE      #!ignore commands that start with space
setopt HIST_SAVE_NO_DUPS      # omit older duped commands 
setopt HIST_VERIFY            # expand command history before running
setopt SHARE_HISTORY          #!share history with other sessions

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

###> environment variables
export PAGER="most"
export VISUAL="code"
export EDITOR="code"
###> command aliases
alias ls='ls --color'
alias c='clear'

###>  integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

###> Zinit annexes, don't touch and leave last
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
