# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=**'

setopt CORRECT

plugins=(
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-you-should-use
    history-substring-search
    fzf
)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-fzf-plugin/fzf.plugin.zsh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias c='clear'                                                        # clear terminal
alias l='eza -lh --icons=auto'                                         # long list
alias ls='eza -1 --icons=auto'                                         # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto'                                       # long list dirs
alias lt='eza --icons=auto --tree'                                     # list folder as tree
alias un='yay -Rns'                                                    # uninstall package
alias up='yay -Syu'                                                    # update system/package/aur
alias pl='yay -Qs'                                                     # list installed package
alias pa='yay -Ss'                                                     # list available package
alias pc='yay -Sc'                                                     # remove unused cache
alias po='yay -Qtdq | yay -Rns -'                                      # remove unused packages, also try > $aurhe>
alias fastfetch='fastfetch --logo-type kitty'
alias ~='cd ~'
alias /='cd /'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'
alias search='sudo find . -iname '
alias searchin='sudo grep -rnw "." -e '
alias BUT='cd ~/Documents/Travail/BUT_INFO'
alias S1='cd ~/Documents/Travail/BUT_INFO/BUT1/S1'
alias S2='cd ~/Documents/Travail/BUT_INFO/BUT1/S2'
alias S3='cd ~/Documents/Travail/BUT_INFO/BUT2/S3'
alias S4='cd ~/Documents/Travail/BUT_INFO/BUT2/S4'
alias SAE='cd ~/Documents/Travail/BUT_INFO/BUT2/SAE'
alias conf='cd ~/.config/hypr'
alias src='cd ~/.local/share/bin'
alias coding='cd ~/Documents/coding/'
alias setwallpaper=~/set_wallpaper.sh
alias vpn='sudo openfortivpn u-vpn-plus.unilim.fr --saml-login'
alias startweb='sudo systemctl start httpd && systemctl status httpd && sudo systemctl start mariadb && systemctl status mariadb'
alias rmnot='sudo ~/rmnot.sh'


# Binds

# Home / End keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Delete key
bindkey "^[[3~" delete-char

# Ctrl + Flèche
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Ctrl + Backspace : Supprimer mot à gauche
bindkey "^H" backward-kill-word
bindkey "^[^H" backward-kill-word
bindkey "^[[3;5~" kill-word  # parfois nécessaire

# Ctrl + Delete : Supprimer mot à droite
bindkey "^[[3;5~" kill-word


setopt extended_glob

eval "$(zoxide init --cmd cd  zsh)"
